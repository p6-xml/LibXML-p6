use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::debugXML;
# Tree debugging APIs:
#    Interfaces to a set of routines used for debugging the tree produced by the XML parser. 
use LibXML::Native::Defs :LIB, :XmlCharP;

struct xmlShellCtxt is repr('CStruct') {
    has Str $.filename;
    has xmlDoc $.doc;
    has xmlNode $.node;
    has xmlXPathContext $.pctxt;
    has int32 $.loaded;
    has FILE * $.output;
    has xmlShellReadlineFunc $.input;
    method xmlShellBase(Str $arg, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellCat(Str $arg, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellDir(Str $arg, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellDu(Str $arg, xmlNode $tree, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellList(Str $arg, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellLoad(Str $filename, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellPwd(Str $buffer, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellSave(Str $filename, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellValidate(Str $dtd, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
    method xmlShellWrite(Str $filename, xmlNode $node, xmlNode $node2 --> int32) is native(LIB) {*};
}
    sub xmlBoolToText(int32 $boolval --> Str) is native(LIB) {*};
    sub xmlDebugCheckDocument(FILE * $output, xmlDoc $doc --> int32) is native(LIB) {*};
    sub xmlDebugDumpAttr(FILE * $output, xmlAttr $attr, int32 $depth --> void) is native(LIB) {*};
    sub xmlDebugDumpAttrList(FILE * $output, xmlAttr $attr, int32 $depth --> void) is native(LIB) {*};
    sub xmlDebugDumpDTD(FILE * $output, xmlDtd $dtd --> void) is native(LIB) {*};
    sub xmlDebugDumpDocument(FILE * $output, xmlDoc $doc --> void) is native(LIB) {*};
    sub xmlDebugDumpDocumentHead(FILE * $output, xmlDoc $doc --> void) is native(LIB) {*};
    sub xmlDebugDumpEntities(FILE * $output, xmlDoc $doc --> void) is native(LIB) {*};
    sub xmlDebugDumpNode(FILE * $output, xmlNode $node, int32 $depth --> void) is native(LIB) {*};
    sub xmlDebugDumpNodeList(FILE * $output, xmlNode $node, int32 $depth --> void) is native(LIB) {*};
    sub xmlDebugDumpOneNode(FILE * $output, xmlNode $node, int32 $depth --> void) is native(LIB) {*};
    sub xmlDebugDumpString(FILE * $output, xmlCharP $str --> void) is native(LIB) {*};
    sub xmlLsOneNode(FILE * $output, xmlNode $node --> void) is native(LIB) {*};
    sub xmlShellPrintXPathError(int32 $errorType, Str $arg --> void) is native(LIB) {*};