unit role LibXML::Raw::DOM::Document;

use LibXML::Raw::DOM::Node;

use LibXML::Enums;
use LibXML::Types :QName, :NCName;
use NativeCall;

my constant Node = LibXML::Raw::DOM::Node;
my subset DocNode of Node where { !.defined || .type == XML_DOCUMENT_NODE } 
my subset DtdNode of Node where { !.defined || .type == XML_DTD_NODE } 

method GetRootElement  { ... }
method SetRootElement  { ... }
method NewProp { ... }
method GetID { ... }
method domCreateAttribute {...}
method domCreateAttributeNS {...}
method domImportNode {...}
method domGetInternalSubset { ... }
method domGetExternalSubset { ... }
method domSetInternalSubset { ... }
method domSetExternalSubset { ... }
method GetCompressMode { ... }
method SetCompressMode { ... }
method new-node { ... }

method getDocumentElement { self.GetRootElement }
method setDocumentElement(Node $e) { self.SetRootElement($e) }

method createElementNS(Str $URI, Str:D $name is copy) {
    return self.createElement($name) without $URI;
    my Str $prefix;
    given $name.split(':', 2) {
        when 2 {
            $prefix = .[0];
            $name   = .[1];
        }
    }
    my $ns = self.oldNs.new: :$URI, :$prefix;
    self.new-node: :$name, :$ns;
}

method createElement(Str:D $name) {
    self.new-node: :$name;
}

method createAttribute(Str:D $name, Str $value = '') {
    self.domCreateAttribute($name, $value);
}

my enum <Copy Move>;

method importNode($node) is default {
    self.domImportNode($node, Copy, 1);
}

method adoptNode($node) is default {
    self.domImportNode($node, Move, 1);
}

method createAttributeNS(Str $URI, Str:D $name, Str:D $value = '') {
    if $URI {
        self.domCreateAttributeNS($URI, $name, $value);
    }
    else {
        self.domCreateAttribute($name, $value);
    }
}

method getInternalSubset {
    self.domGetInternalSubset;
}

method getExternalSubset {
    self.domGetExternalSubset;
}

method setInternalSubset(DtdNode:D $dtd) {
    self.domSetInternalSubset($dtd) // self.dom-error;
}

method setExternalSubset(DtdNode:D $dtd) {
    self.domSetExternalSubset($dtd) // self.dom-error;
}

method removeInternalSubset {
    my $rv = self.getInternalSubset;
    .Unlink with $rv;
    $rv;
}

method removeExternalSubset {
    my $rv = self.getExternalSubset;
    .Unlink with $rv;
    $rv;
}

method getElementById(Str:D $id) {
    my Node $elem = self.GetID($id);
    with $elem {
        $_ .= parent
            if .type == XML_ATTRIBUTE_NODE
    }
    $elem;
}

method setCompression(Int:D $_) { self.SetCompressMode($_) }
method getCompression(--> Int:D) { self.GetCompressMode }

