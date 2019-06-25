use v6;
use LibXML::Node :output-options;

unit class LibXML::Document
    is LibXML::Node;

use LibXML::Native;
use LibXML::Enums;
use LibXML::Config;
use LibXML::Element;
use LibXML::ElementDecl;
use LibXML::Attr;
use LibXML::AttrDecl;
use LibXML::Dtd;
use LibXML::EntityDecl;
use LibXML::EntityRef;
use LibXML::Types :QName, :NCName;
use LibXML::Parser::Context;
use Method::Also;
use NativeCall;

enum XmlStandalone is export(:XmlStandalone) (
    XmlStandaloneYes => 1,
    XmlStandaloneNo => 0,
    XmlStandaloneMu => -1,
);

constant config = LibXML::Config;
has LibXML::Parser::Context $.ctx handles <wellFormed valid>;
has LibXML::Element $!documentElement;

method native is rw handles <compression encoding setCompression standalone URI> { callsame() }
method doc { self }

submethod TWEAK(
                Str :$version,
                xmlEncodingStr :$enc,
                Str :$URI,
               ) {
    my xmlDoc:D $struct = self.native //= xmlDoc.new;
    $struct.version = $_ with $version;
    $struct.encoding = $_ with $enc;
    $struct.URI = $_ with $URI;
    with $struct.documentElement {
        $!documentElement .= new: :native($_), :doc(self);
    }
}

method version { Version.new($.native.version) }

# DOM Methods

multi method createElement(QName $name, Str:D :$href!) {
    $.createElementNS($href, $name);
}
multi method createElement(QName $name) {
    LibXML::Element.box: $.native.createElement($name);
}
method createElementNS(Str:D $href, QName:D $name) {
    LibXML::Element.box: $.native.createElementNS($href, $name);
}

method !check-new-node($node, |) {
   if $node ~~ LibXML::Element {
       die "Document already has a root element"
           with $.documentElement;
   }
}

# don't allow more than one element in the document root
method appendChild(LibXML::Node:D $node)    { self!check-new-node($node); nextsame; }
method addChild(LibXML::Node:D $node)       { self!check-new-node($node); nextsame; }
method insertBefore(LibXML::Node:D $node, LibXML::Node $) { self!check-new-node($node); nextsame; }
method insertAfter(LibXML::Node:D $node, LibXML::Node $)  { self!check-new-node($node); nextsame; }

method importNode(LibXML::Node:D $node) { LibXML::Node.box: $.native.importNode($node.native); }
method adoptNode(LibXML::Node:D $node)  { LibXML::Node.box: $.native.adoptNode($node.native); }

method getDocumentElement { $!documentElement }
method setDocumentElement(LibXML::Element $_) {
    $.documentElement = $_;
}
method documentElement is rw {
    Proxy.new(
        FETCH => sub ($) {
            $!documentElement;
        },
        STORE => sub ($, $!documentElement) {
            $!documentElement.doc = self;
            $.native.documentElement = $!documentElement.native;
        }
    );
}

my subset NameVal of Pair where .key ~~ QName:D && .value ~~ Str:D;
multi method createAttribute(NameVal $_!, |c) {
    $.createAttribute(.key, .value, |c);
}

multi method createAttribute(QName:D $name,
                             Str $value = '',
                             Str:D :$href!,
                            ) {
    LibXML::Attr.box: $.native.createAttributeNS($href, $name, $value);
}

multi method createAttribute(QName:D $name,
                             Str $value = '',
                            ) {
    LibXML::Attr.box: $.native.createAttribute($name, $value);
}

multi method createAttributeNS(Str $href, NameVal $_!, |c) {
    $.createAttributeNS($href, .key, .value, |c);
}
multi method createAttributeNS(Str $href,
                         QName:D $name,
                         Str $value = '',
                        ) {
    LibXML::Attr.box: $.native.createAttributeNS($href, $name, $value);
}

multi method createDocument(Str() $version, xmlEncodingStr:D $enc) {
    self.new: :$version, :$enc;
}
multi method createDocument(Str $URI? is copy, QName $name?, Str $doc-type?, Str :URI($uri), *%opt) {
    $URI //= $uri;
    my $doc = self.new: :$URI, |%opt;
    with $name {
        my LibXML::Node:D $elem = $doc.createElementNS($URI, $_);
        $doc.setDocumentElement($elem);
    }
    $doc.setExternalSubset($_) with $doc-type;
    $doc;
}

method createDocumentFragment() {
    require LibXML::DocumentFragment;
    LibXML::DocumentFragment.new: :doc(self);
}

method createTextNode(Str $content) {
    require LibXML::Text;
    LibXML::Text.new: :doc(self), :$content;
}

method createComment(Str $content) {
    require LibXML::Comment;
    LibXML::Comment.new: :doc(self), :$content;
}

method createCDATASection(Str $content) {
    require LibXML::CDATASection;
    LibXML::CDATASection.new: :doc(self), :$content;
}

method createEntityReference(Str $name) {
    require LibXML::EntityRef;
    LibXML::EntityRef.new: :doc(self), :$name;
}

method createProcessingInstruction(|c) {
    $.createPI(|c);
}

multi method createPI(NameVal $_!, |c) {
    $.createPI(.key, .value, |c);
}
multi method createPI(NCName $name, Str $content?) {
    need LibXML::PI;
    LibXML::PI.new: :doc(self), :$name, :$content;
}

method createExternalSubset(Str $name, Str $external-id, Str $system-id) {
    LibXML::Dtd.new: :doc(self), :type<external>, :$name, :$external-id, :$system-id;
}

method createInternalSubset(Str $name, Str $external-id, Str $system-id) {
    LibXML::Dtd.new: :doc(self), :type<internal>, :$name, :$external-id, :$system-id;
}

method createDTD(Str $name, Str $external-id, Str $system-id) {
    LibXML::Dtd.new: :$name, :$external-id, :$system-id, :type<external>;
}

method getInternalSubset {
    LibXML::Dtd.box: self.native.getInternalSubset;
}

method setInternalSubset(LibXML::Dtd $dtd) {
    self.native.setInternalSubset: $dtd.native;
}

method removeInternalSubset {
    LibXML::Dtd.box: self.native.removeInternalSubset;
}

method indexElements { $.native.IndexElements }

method setURI(Str $uri) { self.URI = $_ }
method actualEncoding { $.encoding || 'UTF-8' }
method setEncoding(xmlEncodingStr $enc) { $.encoding = $enc }
method setStandalone(Numeric $_) {
    $.native.standalone = .defined
        ?? ($_ == 0 ?? XmlStandaloneYes !!  XmlStandaloneNo)
        !! XmlStandaloneMu
}

method internalSubset is rw {
    Proxy.new( FETCH => sub ($) { self.getInternalSubset },
               STORE => sub ($, LibXML::Dtd $dtd) {
                     self.setInternalSubset($dtd);
                 }
             );
}

method getExternalSubset {
    LibXML::Dtd.box: self.native.getExternalSubset;
}

method setExternalSubset(LibXML::Dtd $dtd) {
    self.native.setExternalSubset: $dtd.native;
}

method removeExternalSubset {
    LibXML::Dtd.box: self.native.removeExternalSubset;
}

method getElementById(Str:D $id --> LibXML::Node) is also< getElementsById> {
    LibXML::Node.box: self.native.getElementById($id);
}

method externalSubset is rw {
    Proxy.new( FETCH => sub ($) { self.getExternalSubset },
               STORE => sub ($, LibXML::Dtd $dtd) {
                     self.setExternalSubset($dtd);
                 }
             );
}

method !validate(LibXML::Dtd:D $dtd-obj = self.getInternalSubset // self.getExternalSubset // fail "no dtd found" --> Bool) {
    my xmlValidCtxt $cvp .= new;
    my xmlDoc:D $doc = self.native;
    my xmlDtd $dtd = .native with $dtd-obj;
    # todo: set up error handling
    ? $cvp.validate(:$doc, :$dtd);
}

method validate(|c) { LibXML::Parser::Context.try: {self!validate(|c)} }
method is-valid(|c) { self!validate(|c) }

method processXIncludes(|c) is also<process-xinclude> {
    (require ::('LibXML::Parser')).new.processXIncludes(self, |c);
}

our $lock = Lock.new;

method serialize-html(Bool :$format = True) {
    my buf8 $buf;

    given self.native -> xmlDoc:D $_ {
        my htmlDoc:D $html-doc = nativecast(htmlDoc, $_);
        $html-doc.dump(:$format);
    }
}

method Str(Bool :$skip-dtd = config.skip-dtd, Bool :$HTML = $.native.isa(htmlDoc), |c --> Str) {
    my Str $rv;

    with self.native -> xmlDoc:D $doc {

        my $skipped-dtd = $doc.getInternalSubset
            if $skip-dtd;

        with $skipped-dtd {
            $lock.lock;
            .Unlink;
        }

        $rv := $HTML
            ?? self.serialize-html(|c)
            !! callwith(|c);

        with $skipped-dtd {
            $doc.setInternalSubset($_);
            $lock.unlock;
        }
    }

    $rv;
}

method Blob(Bool() :$skip-decl = config.skip-xml-declaration,
            Bool() :$skip-dtd =  config.skip-dtd,
            xmlEncodingStr:D :$enc is copy = self.encoding // 'UTF-8',
            |c  --> Blob) {

    my Blob $rv;

    if $skip-decl {
        # losing the declaration that encludes the encoding scheme; we need
        # to switch to UTF-8 (default encoding) to stay conformant.
        $enc = 'UTF-8';
    }

    with self.native -> xmlDoc:D $doc {

        my $skipped-dtd = $doc.getInternalSubset
            if $skip-dtd;

        with $skipped-dtd {
            $lock.lock;
            .Unlink;
        }

        $rv := callwith(:$enc, :$skip-decl, |c);

        with $skipped-dtd {
            $doc.setInternalSubset($_);
            $lock.unlock;
        }
    }

    $rv;
}

=begin pod
=head1 NAME

XML::LibXML::Document - XML::LibXML DOM Document Class

=head1 SYNOPSIS



  use LibXML::Document;
  # Only methods specific to Document nodes are listed here,
  # see the LibXML::Node manpage for other methods

  my LibXML::Document $dom .= new;
  my LibXML::Document $dom .= createDocument($version, $encoding);
  $strURI = $doc.URI();
  $doc.setURI($strURI);
  my Str $enc = $doc.encoding();
  $enc = $doc.actualEncoding();
  $doc.encoding = $new-encoding;
  my Version $v = $doc.version();
  $doc.standalone;
  $doc.standalone = $numvalue;
  my $compression = $doc.compression;
  $doc.setCompression($ziplevel);
  $docstring = $dom.Str(:$format, :$HTML);
  $c14nstr = $doc.Str: :C14N, :$comments, :$xpath, :$exclusive, :$selector;
  $str = $doc.serialize(:$format);
  $state = $doc.write: :io($filename), :$format;
  $state = $doc.write: :io($fh), :$format;
  $str = $document.Str(:HTML);
  $str = $document.serialize-html();
  $bool = $dom.is_valid();
  $dom.validate();
  $root = $dom.documentElement();
  $dom.documentElement = $root;
  $element = $dom.createElement( $nodename );
  $element = $dom.createElementNS( $namespaceURI, $nodename );
  $text = $dom.createTextNode( $content_text );
  $comment = $dom.createComment( $comment_text );
  $attrnode = $doc.createAttribute($name [,$value]);
  $attrnode = $doc.createAttributeNS( namespaceURI, $name [,$value] );
  $fragment = $doc.createDocumentFragment();
  $cdata = $dom.createCDATASection( $cdata_content );
  my $pi = $doc.createProcessingInstruction( $target, $data );
  my $entref = $doc.createEntityReference($refname);
  $dtd = $document.createInternalSubset( $rootnode, $public, $system);
  $dtd = $document.createExternalSubset( $rootnode_name, $publicId, $systemId);
  $document.importNode( $node );
  $document.adoptNode( $node );
  my $dtd = $doc.externalSubset;
  my $dtd = $doc.internalSubset;
  $doc.externalSubset = $dtd;
  $doc.internalSubset = $dtd;
  my $dtd = $doc.removeExternalSubset();
  my $dtd = $doc.removeInternalSubset();
  my @nodelist = $doc.getElementsByTagName($tagname);
  my @nodelist = $doc.getElementsByTagNameNS($nsURI,$tagname);
  my @nodelist = $doc.getElementsByLocalName($localname);
  my $node = $doc.getElementById($id);
  $dom.indexElements();

=head1 DESCRIPTION

The Document Class is in most cases the result of a parsing process. But
sometimes it is necessary to create a Document from scratch. The DOM Document
Class provides functions that conform to the DOM Core naming style.

It inherits all functions from L<<<<<< LibXML::Node >>>>>> as specified in the DOM specification. This enables access to the nodes besides
the root element on document level - a C<<<<<< DTD >>>>>> for example. The support for these nodes is limited at the moment.

=head1 METHODS

Many functions listed here are extensively documented in the DOM Level 3 specification (L<<<<<< http://www.w3.org/TR/DOM-Level-3-Core/ >>>>>>). Please refer to the specification for extensive documentation.

=begin item
new

  $dom = LibXML::Document.new;

=end item

=begin item
createDocument

  $dom = LibXML::Document.createDocument( $version, $encoding );

DOM-style constructor for the document class. As Parameter it takes the version
string and (optionally) the encoding string. Simply calling I<<<<<< createDocument >>>>>>() will create the document:



  <?xml version="your version" encoding="your encoding"?>

Both parameter are optional. The default value for I<<<<<< $version >>>>>> is C<<<<<< 1.0 >>>>>>, of course. If the I<<<<<< $encoding >>>>>> parameter is not set, the encoding will be left unset, which means UTF-8 is
implied.

The call of I<<<<<< createDocument >>>>>>() without any parameter will result the following code:



  <?xml version="1.0"?>

Alternatively one can call this constructor directly from the LibXML class
level, to avoid some typing. This will not have any effect on the class
instance, which is always LibXML::Document.



  my $document = LibXML.createDocument( "1.0", "UTF-8" );

is therefore a shortcut for



  my $document = LibXML::Document.createDocument( "1.0", "UTF-8" );
=end item


=begin item
URI

  my Str $URI = $doc.URI();
  $doc.URI = $URI;

Gets or Sets the URI (or filename) of the original document. For documents obtained
by parsing a string of a FH without using the URI parsing argument of the
corresponding C<<<<<< parse_* >>>>>> function, the result is a generated string unknown-XYZ where XYZ is some
number; for documents created with the constructor C<<<<<< new >>>>>>, the URI is undefined.

=end item

=begin item
encoding

    my Str $enc = $doc.encoding();
    $doc.encoding = $new-encoding;

returns or sets the encoding of the document.

=item * The `.Str` method treats the encoding as a subset. Any characters that fall outside the encoding set are encoded as entities (e.g. `&nbsp;`)
=item 8 The `.Blob` method will fully render the XML document in as a Blob with the specified encoding.


  my $doc = LibXML.createDocument( "1.0", "ISO-8859-15" );
  print $doc.encoding; # prints ISO-8859-15
  my $xml-with-entities = $doc.Str;
  'encoded.xml'.IO.spurt( $doc.Blob, :bin);

=end item


=begin item
  actualEncoding

  $strEncoding = $doc.actualEncoding();

returns the encoding in which the XML will be returned by $doc.toString().
This is usually the original encoding of the document as declared in the XML
declaration and returned by $doc.encoding. If the original encoding is not
known (e.g. if created in memory or parsed from a XML without a declared
encoding), 'UTF-8' is returned.


  my $doc = LibXML.createDocument( "1.0", "ISO-8859-15" );
  print $doc.encoding; # prints ISO-8859-15

=end item


=begin item
version

  my Version $v = $doc.version();

returns the version of the document

I<<<<<< getVersion() >>>>>> is an alternative form of this function.

=end item


=begin item
standalone

  use LibXML::Document :XmlStandalone;
  if $doc.standalone == XmlStandaloneYes { ... }

This function returns the Numerical value of a documents XML declarations
standalone attribute. It returns I<<<<<< 1 (XmlStandaloneYes) >>>>>> if standalone="yes" was found, I<<<<<< 0 (XmlStandaloneNo) >>>>>> if standalone="no" was found and I<<<<<< -1 (XmlStandaloneMu) >>>>>> if standalone was not specified (default on creation).
=end item



=begin item
setStandalone

  use LibXML::Document :XmlStandalone;
  $doc.setStandalone($numvalue);

Through this method it is possible to alter the value of a documents standalone
attribute. Set it to I<<<<<< 1 (XmlStandaloneYes) >>>>>> to set standalone="yes", to I<<<<<< 0 (XmlStandaloneNo) >>>>>> to set standalone="no" or set it to I<<<<<< -1 (XmlStandaloneMu) >>>>>> to remove the standalone attribute from the XML declaration.
=end item

=begin item
compression

  my $compression = $doc.compression;
  $doc.compression = $ziplevel;

libxml2 allows reading of documents directly from gzipped files. In this case
the compression variable is set to the compression level of that file (0-8). If
LibXML parsed a different source or the file wasn't compressed, the
returned value will be I<<<<<< -1 >>>>>>.

If one intends to write the document directly to a file, it is possible to set
the compression level for a given document. This level can be in the range from
0 to 8. If LibXML should not try to compress use I<<<<<< -1 >>>>>> (default).

Note that this feature will I<<<<<< only >>>>>> work if libxml2 is compiled with zlib support and `.write` is used for output.
=end item


=begin item
Str

  $docstring = $dom.Str(:$format);

I<<<<<< Str >>>>>> is a serializing function, so the DOM Tree is serialized into an XML
string, ready for output.


  $file.IO.spurt: $doc.Str;

regardless of the actual encoding of the document. See the section on encodings
in L<<<<<< LibXML >>>>>> for more details.

The optional I<<<<<< $format >>>>>> parameter sets the indenting of the output. This parameter is expected to be an C<<<<<< integer >>>>>> value, that specifies that indentation should be used. The format parameter can
have three different values if it is used:

If $format is 0, than the document is dumped as it was originally parsed

If $format is 1, libxml2 will add ignorable white spaces, so the nodes content
is easier to read. Existing text nodes will not be altered

If $format is 2 (or higher), libxml2 will act as $format == 1 but it add a
leading and a trailing line break to each text node.

libxml2 uses a hard-coded indentation of 2 space characters per indentation
level. This value can not be altered on run-time.
=end item


=begin item
Str: :C14N

  $c14nstr = $doc.Str: :C14N, :$comment, :$xpath;
  $ec14nstr = $doc.Str: :C14N, :exclusive $xpath, :@prefix;

C14N Normalisation. See the documentation in L<<<<<< LibXML::Node >>>>>>.
=end item

=begin item
serialize

  $str = $doc.serialize($format);

An alias for toString(). This function was name added to be more consistent
with libxml2.
=end item


=begin item
write

  $state = $doc.write: :io($filename), :$format;

This function is similar to Str(), but it writes the document directly
into a filesystem. This function is very useful, if one needs to store large
documents.

The format parameter has the same behaviour as in Str().
=end item


=begin item
Str: :HTML

  $str = $document.Str: :HTML;

I<<<<<< .Str: :HTML >>>>>> serializes the tree to a byte string in the document encoding as HTML. With this
method indenting is automatic and managed by libxml2 internally.
=end item


=begin item
serialize-html

  $str = $document.serialize-html();

An alias for Str: :HTML.
=end item


=begin item
is-valid

  $bool = $dom.is-valid();

Returns either True or False depending on whether the DOM Tree is a valid
Document or not.

You may also pass in a L<<<<<< LibXML::Dtd >>>>>> object, to validate against an external DTD:
=end item



  unless $dom.is-valid(:$dtd) {
       warn("document is not valid!");
   }


=begin item
validate

  $dom.validate();

This is an exception throwing equivalent of is_valid. If the document is not
valid it will throw an exception containing the error. This allows you much
better error reporting than simply is_valid or not.

Again, you may pass in a DTD object
=end item


=begin item
documentElement

  $root = $dom.documentElement();
  $dom.documentElement = $root;

Returns the root element of the Document. A document can have just one root
element to contain the documents data.

This function also enables you to set the root element for a document. The function
supports the import of a node from a different document tree, but does not
support a document fragment as $root.
=end item


=begin item
createElement

  $element = $dom.createElement( $nodename );

This function creates a new Element Node bound to the DOM with the name C<<<<<< $nodename >>>>>>.
=end item


=begin item
createElementNS

  $element = $dom.createElementNS( $namespaceURI, $nodename );

This function creates a new Element Node bound to the DOM with the name C<<<<<< $nodename >>>>>> and placed in the given namespace.
=end item


=begin item
createTextNode

  $text = $dom.createTextNode( $content_text );

As an equivalent of I<<<<<< createElement >>>>>>, but it creates a I<<<<<< Text Node >>>>>> bound to the DOM.
=end item

=begin item
createComment

  $comment = $dom.createComment( $comment_text );

As an equivalent of I<<<<<< createElement >>>>>>, but it creates a I<<<<<< Comment Node >>>>>> bound to the DOM.
=end item


=begin item
createAttribute

  $attrnode = $doc.createAttribute($name [,$value]);

Creates a new Attribute node.
=end item


=begin item
createAttributeNS

  $attrnode = $doc.createAttributeNS( namespaceURI, $name [,$value] );

Creates an Attribute bound to a namespace.
=end item


=begin item
createDocumentFragment

  $fragment = $doc.createDocumentFragment();

This function creates a DocumentFragment.
=end item


=begin item
createCDATASection

  $cdata = $dom.createCDATASection( $cdata_content );

Similar to createTextNode and createComment, this function creates a
CDataSection bound to the current DOM.
=end item


=begin item
createProcessingInstruction

  my $pi = $doc.createProcessingInstruction( $target, $data );

create a processing instruction node.

Since this method is quite long one may use its short form I<<<<<< createPI() >>>>>>.
=end item


=begin item
createEntityReference

  my $entref = $doc.createEntityReference($refname);

If a document has a DTD specified, one can create entity references by using
this function. If one wants to add a entity reference to the document, this
reference has to be created by this function.

An entity reference is unique to a document and cannot be passed to other
documents as other nodes can be passed.

I<<<<<< NOTE: >>>>>> A text content containing something that looks like an entity reference, will
not be expanded to a real entity reference unless it is a predefined entity



  my $string = "&foo;";
   $some_element.appendText( $string );
   print $some_element.textContent; # prints "&amp;foo;"
=end item


=begin item
createInternalSubset

  $dtd = $document.createInternalSubset( $rootnode, $public, $system);

This function creates and adds an internal subset to the given document.
Because the function automatically adds the DTD to the document there is no
need to add the created node explicitly to the document.



  my $document = LibXML::Document.new();
   my $dtd      = $document.createInternalSubset( "foo", undef, "foo.dtd" );

will result in the following XML document:



  <?xml version="1.0"?>
   <!DOCTYPE foo SYSTEM "foo.dtd">

By setting the public parameter it is possible to set PUBLIC DTDs to a given
document. So



  my $document = LibXML::Document.new();
  my $dtd      = $document.createInternalSubset( "foo", "-//FOO//DTD FOO 0.1//EN", undef );

will cause the following declaration to be created on the document:



  <?xml version="1.0"?>
  <!DOCTYPE foo PUBLIC "-//FOO//DTD FOO 0.1//EN">
=end item


=begin item
createExternalSubset

  $dtd = $document.createExternalSubset( $rootnode_name, $publicId, $systemId);

This function is similar to C<<<<<< createInternalSubset() >>>>>> but this DTD is considered to be external and is therefore not added to the
document itself. Nevertheless it can be used for validation purposes.
=end item


=begin item
importNode

  $document.importNode( $node );

If a node is not part of a document, it can be imported to another document. As
specified in DOM Level 2 Specification the Node will not be altered or removed
from its original document (C<<<<<< $node.cloneNode(1) >>>>>> will get called implicitly).

I<<<<<< NOTE: >>>>>> Don't try to use importNode() to import sub-trees that contain an entity
reference - even if the entity reference is the root node of the sub-tree. This
will cause serious problems to your program. This is a limitation of libxml2
and not of LibXML itself.
=end item


=begin item
adoptNode

  $document.adoptNode( $node );

If a node is not part of a document, it can be imported to another document. As
specified in DOM Level 3 Specification the Node will not be altered but it will
removed from its original document.

After a document adopted a node, the node, its attributes and all its
descendants belong to the new document. Because the node does not belong to the
old document, it will be unlinked from its old location first.

I<<<<<< NOTE: >>>>>> Don't try to adoptNode() to import sub-trees that contain entity references -
even if the entity reference is the root node of the sub-tree. This will cause
serious problems to your program. This is a limitation of libxml2 and not of
LibXML itself.
=end item


=begin item
externalSubset

  my $dtd = $doc.externalSubset;

If a document has an external subset defined it will be returned by this
function.

I<<<<<< NOTE >>>>>> Dtd nodes are no ordinary nodes in libxml2. The support for these nodes in
LibXML is still limited. In particular one may not want use common node
function on doctype declaration nodes!
=end item


=begin item
internalSubset

  my $dtd = $doc.internalSubset;

If a document has an internal subset defined it will be returned by this
function.

I<<<<<< NOTE >>>>>> Dtd nodes are no ordinary nodes in libxml2. The support for these nodes in
LibXML is still limited. In particular one may not want use common node
function on doctype declaration nodes!
=end item


=begin item
setExternalSubset

  $doc.setExternalSubset($dtd);

I<<<<<< EXPERIMENTAL! >>>>>>

This method sets a DTD node as an external subset of the given document.
=end item


=begin item
setInternalSubset

  $doc.setInternalSubset($dtd);

I<<<<<< EXPERIMENTAL! >>>>>>

This method sets a DTD node as an internal subset of the given document.
=end item


=begin item
removeExternalSubset

  my $dtd = $doc.removeExternalSubset();

I<<<<<< EXPERIMENTAL! >>>>>>

If a document has an external subset defined it can be removed from the
document by using this function. The removed dtd node will be returned.
=end item


=begin item
removeInternalSubset

  my $dtd = $doc.removeInternalSubset();

I<<<<<< EXPERIMENTAL! >>>>>>

If a document has an internal subset defined it can be removed from the
document by using this function. The removed dtd node will be returned.
=end item


=begin item
getElementsByTagName

  my @nodelist = $doc.getElementsByTagName($tagname);

Implements the DOM Level 2 function

In SCALAR context this function returns an L<<<<<< LibXML::NodeList >>>>>> object.
=end item


=begin item
getElementsByTagNameNS

  my @nodelist = $doc.getElementsByTagNameNS($nsURI,$tagname);

Implements the DOM Level 2 function

In SCALAR context this function returns an L<<<<<< LibXML::NodeList >>>>>> object.
=end item


=begin item
getElementsByLocalName

  my @nodelist = $doc.getElementsByLocalName($localname);

This allows the fetching of all nodes from a given document with the given
Localname.

In SCALAR context this function returns an L<<<<<< LibXML::NodeList >>>>>> object.
=end item


=begin item
getElementById

  my $node = $doc.getElementById($id);

Returns the element that has an ID attribute with the given value. If no such
element exists, this returns undef.

Note: the ID of an element may change while manipulating the document. For
documents with a DTD, the information about ID attributes is only available if
DTD loading/validation has been requested. For HTML documents parsed with the
HTML parser ID detection is done automatically. In XML documents, all "xml:id"
attributes are considered to be of type ID. You can test ID-ness of an
attribute node with $attr.isId().

In versions 1.59 and earlier this method was called getElementsById() (plural)
by mistake. Starting from 1.60 this name is maintained as an alias only for
backward compatibility.
=end item


=begin item
indexElements

  $dom.indexElements();

This function causes libxml2 to stamp all elements in a document with their
document position index which considerably speeds up XPath queries for large
documents. It should only be used with static documents that won't be further
changed by any DOM methods, because once a document is indexed, XPath will
always prefer the index to other methods of determining the document order of
nodes. XPath could therefore return improperly ordered node-lists when applied
on a document that has been changed after being indexed. It is of course
possible to use this method to re-index a modified document before using it
with XPath again. This function is not a part of the DOM specification.

This function returns number of elements indexed, -1 if error occurred, or -2
if this feature is not available in the running libxml2.
=end item


=head1 AUTHORS

Matt Sergeant,
Christian Glahn,
Petr Pajas


=head1 VERSION

2.0132

=head1 COPYRIGHT

2001-2007, AxKit.com Ltd.

2002-2006, Christian Glahn.

2006-2009, Petr Pajas.


=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=end pod
