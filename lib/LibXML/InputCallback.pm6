use v6;

unit class LibXML::InputCallback;

my class CallbackGroup {
    has &.match is required;
    has &.open  is required;
    has &.read  is required;
    has &.close is required;

}

my class Context {
    use NativeCall;

    has $.fh;
    has Pointer $!addr; # Just because libxml2 expects a pointer
    has CallbackGroup $.cb is required handles <match>;
    has Blob $!overflow;

    sub malloc(size_t --> Pointer) is native {*}
    sub free(Pointer:D) is native {*}
    sub memcpy(CArray[uint8], CArray[uint8], size_t --> CArray[uint8]) is native {*}

    submethod DESTROY { free($_) with $!addr }

    method open {
        -> Str:D $file --> Pointer {
            $!fh = $!cb.open.($file);
            with $!fh {
                $_ = Nil if !.so;
            }

            $!addr = malloc(1) with $!fh;
            $!addr;

        }
    }

    method read {
        -> Pointer $addr, CArray $out-arr, UInt $bytes --> Int {
            warn "perculiar" unless +$addr == +$!addr;
            with $!overflow // $!cb.read.($!fh, $bytes) -> Blob $io-buf {
                my $n-read := $io-buf.bytes;
                if $n-read > $bytes {
                    # read-buffer exceeds output buffer size;
                    # hold the excess
                    $!overflow := $io-buf.subbuf($bytes);
                    $io-buf .= subbuf(0, $bytes);
                    $n-read = $bytes;
                }
                else {
                    $!overflow = Nil;
                }

                my CArray[uint8] $io-arr := nativecast(CArray[uint8], $io-buf);
                memcpy($out-arr, $io-arr, $n-read);
                $n-read;
            }
        }
    }

    method close {
        -> Pointer:D $addr --> Int {
            warn "perculiar" unless +$addr == +$!addr;
            my $rv = $!cb.close.($!fh);
            $!fh = Nil;

            with $!addr {
                free($_);
                $_ = Nil;
            }
            # Perl 6 IO functions return True on successful close
            $rv = 0 if $rv.so;
            $rv;
        }
    }
}

has CallbackGroup @!callbacks;
method callbacks { @!callbacks }

multi method TWEAK( Hash :$callbacks ) {
    @!callbacks = CallbackGroup.new(|$_)
        with $callbacks;
}

method add( :&match!, :&open!, :&read!, :&close! ) {
    my CallbackGroup $cb .= new: :&match, :&open, :&read, :&close;
    @!callbacks.push: $cb;
}

method make-contexts {
    @!callbacks.map: -> $cb { Context.new: :$cb }
}

method pop {
}