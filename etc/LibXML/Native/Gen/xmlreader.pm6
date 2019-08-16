use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::xmlreader;
# the XMLReader implementation:
#    API of the XML streaming API based on C# interfaces. 
use LibXML::Native::Defs :LIB, :XmlCharP;

enum xmlParserProperties is export {
    XML_PARSER_DEFAULTATTRS => 2,
    XML_PARSER_LOADDTD => 1,
    XML_PARSER_SUBST_ENTITIES => 4,
    XML_PARSER_VALIDATE => 3,
}

enum xmlParserSeverities is export {
    XML_PARSER_SEVERITY_ERROR => 4,
    XML_PARSER_SEVERITY_VALIDITY_ERROR => 2,
    XML_PARSER_SEVERITY_VALIDITY_WARNING => 1,
    XML_PARSER_SEVERITY_WARNING => 3,
}

enum xmlReaderTypes is export {
    XML_READER_TYPE_ATTRIBUTE => 2,
    XML_READER_TYPE_CDATA => 4,
    XML_READER_TYPE_COMMENT => 8,
    XML_READER_TYPE_DOCUMENT => 9,
    XML_READER_TYPE_DOCUMENT_FRAGMENT => 11,
    XML_READER_TYPE_DOCUMENT_TYPE => 10,
    XML_READER_TYPE_ELEMENT => 1,
    XML_READER_TYPE_END_ELEMENT => 15,
    XML_READER_TYPE_END_ENTITY => 16,
    XML_READER_TYPE_ENTITY => 6,
    XML_READER_TYPE_ENTITY_REFERENCE => 5,
    XML_READER_TYPE_NONE => 0,
    XML_READER_TYPE_NOTATION => 12,
    XML_READER_TYPE_PROCESSING_INSTRUCTION => 7,
    XML_READER_TYPE_SIGNIFICANT_WHITESPACE => 14,
    XML_READER_TYPE_TEXT => 3,
    XML_READER_TYPE_WHITESPACE => 13,
    XML_READER_TYPE_XML_DECLARATION => 17,
}

enum xmlTextReaderMode is export {
    XML_TEXTREADER_MODE_CLOSED => 4,
    XML_TEXTREADER_MODE_EOF => 3,
    XML_TEXTREADER_MODE_ERROR => 2,
    XML_TEXTREADER_MODE_INITIAL => 0,
    XML_TEXTREADER_MODE_INTERACTIVE => 1,
    XML_TEXTREADER_MODE_READING => 5,
}

struct xmlTextReader is repr('CPointer') {
}

sub xmlFreeTextReader(xmlTextReaderPtr $reader) is native(LIB) {*};
sub xmlNewTextReader(xmlParserInputBufferPtr $input, Str $URI --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlNewTextReaderFilename(Str $URI --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlReaderForDoc(xmlCharP $cur, Str $URL, Str $encoding, int32 $options --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlReaderForFd(int32 $fd, Str $URL, Str $encoding, int32 $options --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlReaderForFile(Str $filename, Str $encoding, int32 $options --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlReaderForIO(xmlInputReadCallback $ioread, xmlInputCloseCallback $ioclose, Pointer $ioctx, Str $URL, Str $encoding, int32 $options --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlReaderForMemory(Str $buffer, int32 $size, Str $URL, Str $encoding, int32 $options --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlReaderNewDoc(xmlTextReaderPtr $reader, xmlCharP $cur, Str $URL, Str $encoding, int32 $options --> int32) is native(LIB) {*};
sub xmlReaderNewFd(xmlTextReaderPtr $reader, int32 $fd, Str $URL, Str $encoding, int32 $options --> int32) is native(LIB) {*};
sub xmlReaderNewFile(xmlTextReaderPtr $reader, Str $filename, Str $encoding, int32 $options --> int32) is native(LIB) {*};
sub xmlReaderNewIO(xmlTextReaderPtr $reader, xmlInputReadCallback $ioread, xmlInputCloseCallback $ioclose, Pointer $ioctx, Str $URL, Str $encoding, int32 $options --> int32) is native(LIB) {*};
sub xmlReaderNewMemory(xmlTextReaderPtr $reader, Str $buffer, int32 $size, Str $URL, Str $encoding, int32 $options --> int32) is native(LIB) {*};
sub xmlReaderNewWalker(xmlTextReaderPtr $reader, xmlDocPtr $doc --> int32) is native(LIB) {*};
sub xmlReaderWalker(xmlDocPtr $doc --> xmlTextReaderPtr) is native(LIB) {*};
sub xmlTextReaderAttributeCount(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderBaseUri(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderByteConsumed(xmlTextReaderPtr $reader --> long) is native(LIB) {*};
sub xmlTextReaderClose(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderConstBaseUri(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstEncoding(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstLocalName(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstName(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstNamespaceUri(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstPrefix(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstString(xmlTextReaderPtr $reader, xmlCharP $str --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstValue(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstXmlLang(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderConstXmlVersion(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderCurrentDoc(xmlTextReaderPtr $reader --> xmlDocPtr) is native(LIB) {*};
sub xmlTextReaderCurrentNode(xmlTextReaderPtr $reader --> xmlNodePtr) is native(LIB) {*};
sub xmlTextReaderDepth(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderExpand(xmlTextReaderPtr $reader --> xmlNodePtr) is native(LIB) {*};
sub xmlTextReaderGetAttribute(xmlTextReaderPtr $reader, xmlCharP $name --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderGetAttributeNo(xmlTextReaderPtr $reader, int32 $no --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderGetAttributeNs(xmlTextReaderPtr $reader, xmlCharP $localName, xmlCharP $namespaceURI --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderGetErrorHandler(xmlTextReaderPtr $reader, xmlTextReaderErrorFunc * $f, void ** $arg) is native(LIB) {*};
sub xmlTextReaderGetParserColumnNumber(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderGetParserLineNumber(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderGetParserProp(xmlTextReaderPtr $reader, int32 $prop --> int32) is native(LIB) {*};
sub xmlTextReaderGetRemainder(xmlTextReaderPtr $reader --> xmlParserInputBufferPtr) is native(LIB) {*};
sub xmlTextReaderHasAttributes(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderHasValue(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderIsDefault(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderIsEmptyElement(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderIsNamespaceDecl(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderIsValid(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderLocalName(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderLocatorBaseURI(xmlTextReaderLocatorPtr $locator --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderLocatorLineNumber(xmlTextReaderLocatorPtr $locator --> int32) is native(LIB) {*};
sub xmlTextReaderLookupNamespace(xmlTextReaderPtr $reader, xmlCharP $prefix --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderMoveToAttribute(xmlTextReaderPtr $reader, xmlCharP $name --> int32) is native(LIB) {*};
sub xmlTextReaderMoveToAttributeNo(xmlTextReaderPtr $reader, int32 $no --> int32) is native(LIB) {*};
sub xmlTextReaderMoveToAttributeNs(xmlTextReaderPtr $reader, xmlCharP $localName, xmlCharP $namespaceURI --> int32) is native(LIB) {*};
sub xmlTextReaderMoveToElement(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderMoveToFirstAttribute(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderMoveToNextAttribute(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderName(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderNamespaceUri(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderNext(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderNextSibling(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderNodeType(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderNormalization(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderPrefix(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderPreserve(xmlTextReaderPtr $reader --> xmlNodePtr) is native(LIB) {*};
sub xmlTextReaderPreservePattern(xmlTextReaderPtr $reader, xmlCharP $pattern, const xmlChar ** $namespaces --> int32) is native(LIB) {*};
sub xmlTextReaderQuoteChar(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderRead(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderReadAttributeValue(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderReadInnerXml(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderReadOuterXml(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderReadState(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderReadString(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderRelaxNGSetSchema(xmlTextReaderPtr $reader, xmlRelaxNGPtr $schema --> int32) is native(LIB) {*};
sub xmlTextReaderRelaxNGValidate(xmlTextReaderPtr $reader, Str $rng --> int32) is native(LIB) {*};
sub xmlTextReaderRelaxNGValidateCtxt(xmlTextReaderPtr $reader, xmlRelaxNGValidCtxtPtr $ctxt, int32 $options --> int32) is native(LIB) {*};
sub xmlTextReaderSchemaValidate(xmlTextReaderPtr $reader, Str $xsd --> int32) is native(LIB) {*};
sub xmlTextReaderSchemaValidateCtxt(xmlTextReaderPtr $reader, xmlSchemaValidCtxtPtr $ctxt, int32 $options --> int32) is native(LIB) {*};
sub xmlTextReaderSetErrorHandler(xmlTextReaderPtr $reader, xmlTextReaderErrorFunc $f, Pointer $arg) is native(LIB) {*};
sub xmlTextReaderSetParserProp(xmlTextReaderPtr $reader, int32 $prop, int32 $value --> int32) is native(LIB) {*};
sub xmlTextReaderSetSchema(xmlTextReaderPtr $reader, xmlSchemaPtr $schema --> int32) is native(LIB) {*};
sub xmlTextReaderSetStructuredErrorHandler(xmlTextReaderPtr $reader, xmlStructuredErrorFunc $f, Pointer $arg) is native(LIB) {*};
sub xmlTextReaderSetup(xmlTextReaderPtr $reader, xmlParserInputBufferPtr $input, Str $URL, Str $encoding, int32 $options --> int32) is native(LIB) {*};
sub xmlTextReaderStandalone(xmlTextReaderPtr $reader --> int32) is native(LIB) {*};
sub xmlTextReaderValue(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};
sub xmlTextReaderXmlLang(xmlTextReaderPtr $reader --> xmlCharP) is native(LIB) {*};