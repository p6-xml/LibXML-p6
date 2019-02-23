#| low level DOM. Works directly on Native XML Nodes
unit role LibXML::Native::DOM::Node;
my constant Node = LibXML::Native::DOM::Node:D;
use LibXML::Enums;
use LibXML::Types :NCName;
use NativeCall;

method doc { ... }
method type { ... }
method children { ... }
method last { ... }

method domAppendChild  { ... }
method domInsertBefore { ... }
method domInsertAfter  { ... }
method domName { ... }
method domGetNodeValue { ... }
method domSetNodeValue { ... }
method domRemoveChild  { ... }
method domGetAttributeNode { ... }
method domSetAttributeNode { ... }
method domXPathSelect  { ... }
method domGetChildrenByLocalName { ... }
method domGetChildrenByTagName { ... }
method domGetChildrenByTagNameNS { ... }

method firstChild { self.children }
method lastChild { self.last }

method appendChild(Node $nNode) {
    if self.type == XML_DOCUMENT_NODE {
        my constant %Unsupported = %(
            (+XML_ELEMENT_NODE) => "Appending an element to a document node not supported yet!",
            (+XML_DOCUMENT_FRAG_NODE) => "Appending a document fragment node to a document node not supported yet!",
            (+XML_TEXT_NODE|+XML_CDATA_SECTION_NODE)
                => "Appending text node not supported on a document node yet!",
        );

        fail $_ with %Unsupported{$nNode.type};
    }
    my Node:D $rNode = self.domAppendChild($nNode);
    self.doc.intSubset = $nNode
        if $rNode.type == XML_DTD_NODE;
    $rNode;
}

my subset AttrNode of Node where .type == XML_ATTRIBUTE_NODE;

method setAttribute(NCName $name, Str $value) {
    self.SetProp($name, $value);
}

method setAttributeNode(AttrNode $att) {
    self.domSetAttributeNode($att);
}

method getAttributeNode(Str:D $att-name) {
    self.domGetAttributeNode($att-name);
}

method removeChild(Node $child) {
    self.domRemoveChild($child);
}

method removeAttribute(Str:D $attr-name) {
    with self.domGetAttributeNode($attr-name) {
        warn "removing $attr-name";
        .Unlink;
    }
}

method !descendants(Str:D $expr = '') {
   self.domXPathSelect("descendant::*" ~ $expr);
}

multi method getElementsByTagName('*') {
    self!descendants;
}
multi method getElementsByTagName(Str:D $name) {
    self!descendants: "[name()='$name']";
}

multi method getElementsByLocalName('*') {
    self!descendants;
}
multi method getElementsByLocalName(Str:D $name) {
    self!descendants: "[local-name()='$name']";
}

multi method getElementsByTagNameNS('*','*') {
    self!descendants;
}
multi method getElementsByTagNameNS(Str() $URI, '*') {
    self!descendants: "[namespace-uri()='$URI']";
}
multi method getElementsByTagNameNS('*', Str $name) {
    self!descendants: "[local-name()='$name']";
}
multi method getElementsByTagNameNS(Str() $URI, Str $name) {
    self!descendants: "[local-name()='$name' and namespace-uri()='$URI']";
}

method getChildrenByLocalName(Str $name) {
    self.domGetChildrenByLocalName($name);
}

method getChildrenByTagName(Str $name) {
    self.domGetChildrenByTagName($name);
}

method getChildrenByTagNameNS(Str $URI, Str $name) {
    self.domGetChildrenByTagNameNS($URI, $name);
}

method insertBefore(Node $nNode, Node $oNode) {
    my Node:D $rNode = self.domInsertBefore($nNode, $oNode);
    self.doc.intSubset = $nNode
        if $rNode.type == XML_DTD_NODE;
    $nNode;
}

method insertAfter(Node $nNode, Node $oNode) {
    my Node:D $rNode = self.domInsertAfter($nNode, $oNode);
    self.doc.intSubset = $nNode
        if $rNode.type == XML_DTD_NODE;
    $nNode;
}

method nodeName { self.domName; }

method nodeValue is rw {
    Proxy.new(
        FETCH => sub ($) { self.domGetNodeValue },
        STORE => sub ($, Str() $_) { self.domSetNodeValue($_) },
    );
}

method hasAttributes returns Bool {
    ? (self.type != XML_ATTRIBUTE_NODE
       && self.type != XML_DTD_NODE
       && self.properties.defined)
}

method hasChildNodes returns Bool {
    ? (self.type != XML_ATTRIBUTE_NODE && self.children.defined)
}

method nextSibling returns Node { self.next; }

method parentNode returns Node { self.parent; }

method nextNonBlankSibling returns Node {
    my $next = self.next;
    $next .= next()
        while $next.defined && $next.isBlankNode;
    $next;
}

method previousSibling returns Node { self.prev; }

method previousNonBlankSibling returns Node {
    my $prev = self.prev;
    $prev .= prev()
        while $prev.defined && $prev.isBlankNode;
    $prev;
}

sub addr($d) { +nativecast(Pointer, $_) with $d;  }

method isSameNode(Node $oNode) {
    addr(self) ~~ addr($oNode);
}

method baseURI is rw {
    Proxy.new(
        FETCH => sub ($) { self.GetBase },
        STORE => sub ($, Str() $uri) { self.SetBase($uri) }
    );
}

