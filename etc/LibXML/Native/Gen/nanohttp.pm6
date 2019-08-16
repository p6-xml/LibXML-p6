use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::nanohttp;
# minimal HTTP implementation:
#    minimal HTTP implementation allowing to fetch resources like external subset. 
use LibXML::Native::Defs :LIB, :XmlCharP;

sub xmlNanoHTTPAuthHeader(Pointer $ctx --> Str) is native(LIB) {*};
sub xmlNanoHTTPCleanup() is native(LIB) {*};
sub xmlNanoHTTPClose(Pointer $ctx) is native(LIB) {*};
sub xmlNanoHTTPContentLength(Pointer $ctx --> int32) is native(LIB) {*};
sub xmlNanoHTTPEncoding(Pointer $ctx --> Str) is native(LIB) {*};
sub xmlNanoHTTPFetch(Str $URL, Str $filename, char ** $contentType --> int32) is native(LIB) {*};
sub xmlNanoHTTPInit() is native(LIB) {*};
sub xmlNanoHTTPMethod(Str $URL, Str $method, Str $input, char ** $contentType, Str $headers, int32 $ilen --> Pointer) is native(LIB) {*};
sub xmlNanoHTTPMethodRedir(Str $URL, Str $method, Str $input, char ** $contentType, char ** $redir, Str $headers, int32 $ilen --> Pointer) is native(LIB) {*};
sub xmlNanoHTTPMimeType(Pointer $ctx --> Str) is native(LIB) {*};
sub xmlNanoHTTPOpen(Str $URL, char ** $contentType --> Pointer) is native(LIB) {*};
sub xmlNanoHTTPOpenRedir(Str $URL, char ** $contentType, char ** $redir --> Pointer) is native(LIB) {*};
sub xmlNanoHTTPRead(Pointer $ctx, Pointer $dest, int32 $len --> int32) is native(LIB) {*};
sub xmlNanoHTTPRedir(Pointer $ctx --> Str) is native(LIB) {*};
sub xmlNanoHTTPReturnCode(Pointer $ctx --> int32) is native(LIB) {*};
sub xmlNanoHTTPSave(Pointer $ctxt, Str $filename --> int32) is native(LIB) {*};
sub xmlNanoHTTPScanProxy(Str $URL) is native(LIB) {*};