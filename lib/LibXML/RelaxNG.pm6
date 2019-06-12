use v6;

unit class LibXML::RelaxNG;

use NativeCall;
use LibXML::Document;
use LibXML::ErrorHandler;
use LibXML::Native;
use LibXML::Native::RelaxNG;
use LibXML::ParserContext;
has xmlRelaxNG $.native;

my class ParserContext {
    has xmlRelaxNGParserCtxt $!native;
    has LibXML::ErrorHandler $!errors handles<generic-error structured-error flush-errors> .= new;

    multi submethod BUILD( xmlRelaxNGParserCtxt:D :$!native! ) {
    }
    multi submethod BUILD(Str:D :$url!) {
        $!native .= new: :$url;
    }
    multi submethod BUILD(Str:D :location($url)!) {
        self.BUILD: :$url;
    }
    multi submethod BUILD(Blob:D :$buf!) {
        $!native .= new: :$buf;
    }
    multi submethod BUILD(Str:D :$string!) {
        my Blob:D $buf = $string.encode;
        self.BUILD: :$buf;
    }
    multi submethod BUILD(LibXML::Document:D :doc($_)!) {
        my xmlDoc:D $doc = .native;
        $!native .= new: :$doc;
    }

    submethod TWEAK {
        $!native.SetStructuredErrorFunc: -> xmlRelaxNGParserCtxt $ctx, xmlError:D $err {
            self.structured-error($err);
        };

    }

    submethod DESTROY {
        .Free with $!native;
    }

    method parse {
        my $rv := $!native.Parse;
        self.flush-errors;
        $rv;
    }

}

my class ValidContext {
    has xmlRelaxNGValidCtxt $!native;
    has LibXML::ErrorHandler $!errors handles<generic-error structured-error flush-errors> .= new;

    multi submethod BUILD( xmlRelaxNGValidCtxt:D :$!native! ) { }
    multi submethod BUILD( LibXML::RelaxNG:D :schema($_)! ) {
        my xmlRelaxNG:D $schema = .native;
        $!native .= new: :$schema;
    }

    submethod TWEAK {
        $!native.SetStructuredErrorFunc: -> xmlRelaxNGValidCtxt $ctx, xmlError:D $err {
                self.structured-error($err);
        };

    }

    submethod DESTROY {
        .Free with $!native;
    }

    method validate(LibXML::Document:D $_) {
        my xmlDoc:D $doc = .native;
        my $rv := $!native.Validate($doc);
        self.flush-errors;
        $rv;
    }

}

submethod TWEAK(|c) {
    my ParserContext:D $parser-ctx .= new: |c;
    $!native = $parser-ctx.parse;
}

has ValidContext $!valid-ctx;
method validate(LibXML::Document:D $doc) {
    $_ .= new: :schema(self)
        without $!valid-ctx;
    $!valid-ctx.validate($doc);
}
