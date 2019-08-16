use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::tree;
# interfaces for tree manipulation:
#    this module describes the structures found in an tree resulting from an XML or HTML parsing, as well as the API provided for various processing on that tree 
use LibXML::Native::Defs :LIB, :XmlCharP;

enum xmlAttributeDefault is export {
    XML_ATTRIBUTE_FIXED => 4,
    XML_ATTRIBUTE_IMPLIED => 3,
    XML_ATTRIBUTE_NONE => 1,
    XML_ATTRIBUTE_REQUIRED => 2,
}

enum xmlAttributeType is export {
    XML_ATTRIBUTE_CDATA => 1,
    XML_ATTRIBUTE_ENTITIES => 6,
    XML_ATTRIBUTE_ENTITY => 5,
    XML_ATTRIBUTE_ENUMERATION => 9,
    XML_ATTRIBUTE_ID => 2,
    XML_ATTRIBUTE_IDREF => 3,
    XML_ATTRIBUTE_IDREFS => 4,
    XML_ATTRIBUTE_NMTOKEN => 7,
    XML_ATTRIBUTE_NMTOKENS => 8,
    XML_ATTRIBUTE_NOTATION => 10,
}

enum xmlBufferAllocationScheme is export {
    XML_BUFFER_ALLOC_BOUNDED => 6,
    XML_BUFFER_ALLOC_DOUBLEIT => 1,
    XML_BUFFER_ALLOC_EXACT => 2,
    XML_BUFFER_ALLOC_HYBRID => 5,
    XML_BUFFER_ALLOC_IMMUTABLE => 3,
    XML_BUFFER_ALLOC_IO => 4,
}

enum xmlDocProperties is export {
    XML_DOC_DTDVALID => 8,
    XML_DOC_HTML => 128,
    XML_DOC_INTERNAL => 64,
    XML_DOC_NSVALID => 2,
    XML_DOC_OLD10 => 4,
    XML_DOC_USERBUILT => 32,
    XML_DOC_WELLFORMED => 1,
    XML_DOC_XINCLUDE => 16,
}

enum xmlElementContentOccur is export {
    XML_ELEMENT_CONTENT_MULT => 3,
    XML_ELEMENT_CONTENT_ONCE => 1,
    XML_ELEMENT_CONTENT_OPT => 2,
    XML_ELEMENT_CONTENT_PLUS => 4,
}

enum xmlElementContentType is export {
    XML_ELEMENT_CONTENT_ELEMENT => 2,
    XML_ELEMENT_CONTENT_OR => 4,
    XML_ELEMENT_CONTENT_PCDATA => 1,
    XML_ELEMENT_CONTENT_SEQ => 3,
}

enum xmlElementType is export {
    XML_ATTRIBUTE_DECL => 16,
    XML_ATTRIBUTE_NODE => 2,
    XML_CDATA_SECTION_NODE => 4,
    XML_COMMENT_NODE => 8,
    XML_DOCB_DOCUMENT_NODE => 21,
    XML_DOCUMENT_FRAG_NODE => 11,
    XML_DOCUMENT_NODE => 9,
    XML_DOCUMENT_TYPE_NODE => 10,
    XML_DTD_NODE => 14,
    XML_ELEMENT_DECL => 15,
    XML_ELEMENT_NODE => 1,
    XML_ENTITY_DECL => 17,
    XML_ENTITY_NODE => 6,
    XML_ENTITY_REF_NODE => 5,
    XML_HTML_DOCUMENT_NODE => 13,
    XML_NAMESPACE_DECL => 18,
    XML_NOTATION_NODE => 12,
    XML_PI_NODE => 7,
    XML_TEXT_NODE => 3,
    XML_XINCLUDE_END => 20,
    XML_XINCLUDE_START => 19,
}

enum xmlElementTypeVal is export {
    XML_ELEMENT_TYPE_ANY => 2,
    XML_ELEMENT_TYPE_ELEMENT => 4,
    XML_ELEMENT_TYPE_EMPTY => 1,
    XML_ELEMENT_TYPE_MIXED => 3,
    XML_ELEMENT_TYPE_UNDEFINED => 0,
}

struct xmlAttr is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # XML_ATTRIBUTE_NODE, must be second !
    has xmlCharP $.name; # the name of the property
    has struct _xmlNode * $.children; # the value of the property
    has struct _xmlNode * $.last; # NULL
    has struct _xmlNode * $.parent; # child->parent link
    has struct _xmlAttr * $.next; # next sibling link
    has struct _xmlAttr * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # the containing document
    has xmlNs * $.ns; # pointer to the associated namespace
    has xmlAttributeType $.atype; # the attribute type if validating
    has Pointer $.psvi; # for type/PSVI informations
}

struct xmlAttribute is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # XML_ATTRIBUTE_DECL, must be second !
    has xmlCharP $.name; # Attribute name
    has struct _xmlNode * $.children; # NULL
    has struct _xmlNode * $.last; # NULL
    has struct _xmlDtd * $.parent; # -> DTD
    has struct _xmlNode * $.next; # next sibling link
    has struct _xmlNode * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # the containing document
    has struct _xmlAttribute * $.nexth; # next in hash table
    has xmlAttributeType $.atype; # The attribute type
    has xmlAttributeDefault $.def; # the default
    has xmlCharP $.defaultValue; # or the default value
    has xmlEnumerationPtr $.tree; # or the enumeration tree if any
    has xmlCharP $.prefix; # the namespace prefix if any
    has xmlCharP $.elem; # Element holding the attribute
}

struct xmlBuf is repr('CPointer') {
}

struct xmlBuffer is repr('CStruct') {
    has xmlCharP $.content; # The buffer content UTF8
    has uint32 $.use; # The buffer size used
    has uint32 $.size; # The buffer size
    has xmlBufferAllocationScheme $.alloc; # The realloc method
    has xmlCharP $.contentIO; # in IO mode we may have a different base
}

struct xmlDOMWrapCtxt is repr('CStruct') {
    has Pointer $._private; # * The type of this context, just in case we need specialized * contexts in the future. *
    has int32 $.type; # * Internal namespace map used for various operations. *
    has Pointer $.namespaceMap; # * Use this one to acquire an xmlNsPtr intended for node->ns. * (Note that this is not intended for elem->nsDef). *
    has xmlDOMWrapAcquireNsFunction $.getNsForNodeFunc;
}

struct xmlDoc is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # XML_DOCUMENT_NODE, must be second !
    has Str $.name; # name/filename/URI of the document
    has struct _xmlNode * $.children; # the document tree
    has struct _xmlNode * $.last; # last child link
    has struct _xmlNode * $.parent; # child->parent link
    has struct _xmlNode * $.next; # next sibling link
    has struct _xmlNode * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # autoreference to itself End of common part
    has int32 $.compression; # level of zlib compression
    has int32 $.standalone; # standalone document (no external refs) 1 if standalone="yes" 0 if standalone="no" -1 if there is no XML declaration -2 if there is an XML declaration, but no standalone attribute was specified
    has struct _xmlDtd * $.intSubset; # the document internal subset
    has struct _xmlDtd * $.extSubset; # the document external subset
    has struct _xmlNs * $.oldNs; # Global namespace, the old way
    has xmlCharP $.version; # the XML version string
    has xmlCharP $.encoding; # external initial encoding, if any
    has Pointer $.ids; # Hash table for ID attributes if any
    has Pointer $.refs; # Hash table for IDREFs attributes if any
    has xmlCharP $.URL; # The URI for that document
    has int32 $.charset; # encoding of the in-memory content actually an xmlCharEncoding
    has struct _xmlDict * $.dict; # dict used to allocate names or NULL
    has Pointer $.psvi; # for type/PSVI informations
    has int32 $.parseFlags; # set of xmlParserOption used to parse the document
    has int32 $.properties; # set of xmlDocProperties for this document set at the end of parsing
}

struct xmlDtd is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # XML_DTD_NODE, must be second !
    has xmlCharP $.name; # Name of the DTD
    has struct _xmlNode * $.children; # the value of the property link
    has struct _xmlNode * $.last; # last child link
    has struct _xmlDoc * $.parent; # child->parent link
    has struct _xmlNode * $.next; # next sibling link
    has struct _xmlNode * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # the containing document End of common part
    has Pointer $.notations; # Hash table for notations if any
    has Pointer $.elements; # Hash table for elements if any
    has Pointer $.attributes; # Hash table for attributes if any
    has Pointer $.entities; # Hash table for entities if any
    has xmlCharP $.ExternalID; # External identifier for PUBLIC DTD
    has xmlCharP $.SystemID; # URI for a SYSTEM or PUBLIC DTD
    has Pointer $.pentities; # Hash table for param entities if any
}

struct xmlElement is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # XML_ELEMENT_DECL, must be second !
    has xmlCharP $.name; # Element name
    has struct _xmlNode * $.children; # NULL
    has struct _xmlNode * $.last; # NULL
    has struct _xmlDtd * $.parent; # -> DTD
    has struct _xmlNode * $.next; # next sibling link
    has struct _xmlNode * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # the containing document
    has xmlElementTypeVal $.etype; # The type
    has xmlElementContentPtr $.content; # the allowed element content
    has xmlAttributePtr $.attributes; # List of the declared attributes
    has xmlCharP $.prefix; # the namespace prefix if any
    has xmlRegexpPtr $.contModel; # the validating regexp
    has Pointer $.contModel;
}

struct xmlElementContent is repr('CStruct') {
    has xmlElementContentType $.type; # PCDATA, ELEMENT, SEQ or OR
    has xmlElementContentOccur $.ocur; # ONCE, OPT, MULT or PLUS
    has xmlCharP $.name; # Element name
    has struct _xmlElementContent * $.c1; # first child
    has struct _xmlElementContent * $.c2; # second child
    has struct _xmlElementContent * $.parent; # parent
    has xmlCharP $.prefix; # Namespace prefix
}

struct xmlEntity is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # XML_ENTITY_DECL, must be second !
    has xmlCharP $.name; # Entity name
    has struct _xmlNode * $.children; # First child link
    has struct _xmlNode * $.last; # Last child link
    has struct _xmlDtd * $.parent; # -> DTD
    has struct _xmlNode * $.next; # next sibling link
    has struct _xmlNode * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # the containing document
    has xmlCharP $.orig; # content without ref substitution
    has xmlCharP $.content; # content or ndata if unparsed
    has int32 $.length; # the content length
    has xmlEntityType $.etype; # The entity type
    has xmlCharP $.ExternalID; # External identifier for PUBLIC
    has xmlCharP $.SystemID; # URI for a SYSTEM or PUBLIC Entity
    has struct _xmlEntity * $.nexte; # unused
    has xmlCharP $.URI; # the full URI as computed
    has int32 $.owner; # does the entity own the childrens
    has int32 $.checked; # was the entity content checked this is also used to count entities * references done from that entity * and if it contains '<'
}

struct xmlEnumeration is repr('CStruct') {
    has struct _xmlEnumeration * $.next; # next one
    has xmlCharP $.name; # Enumeration name
}

struct xmlID is repr('CStruct') {
    has struct _xmlID * $.next; # next ID
    has xmlCharP $.value; # The ID name
    has xmlAttrPtr $.attr; # The attribute holding it
    has xmlCharP $.name; # The attribute if attr is not available
    has int32 $.lineno; # The line number if attr is not available
    has struct _xmlDoc * $.doc; # The document holding the ID
}

struct xmlNode is repr('CStruct') {
    has Pointer $._private; # application data
    has xmlElementType $.type; # type number, must be second !
    has xmlCharP $.name; # the name of the node, or the entity
    has struct _xmlNode * $.children; # parent->childs link
    has struct _xmlNode * $.last; # last child link
    has struct _xmlNode * $.parent; # child->parent link
    has struct _xmlNode * $.next; # next sibling link
    has struct _xmlNode * $.prev; # previous sibling link
    has struct _xmlDoc * $.doc; # the containing document End of common part
    has xmlNs * $.ns; # pointer to the associated namespace
    has xmlCharP $.content; # the content
    has struct _xmlAttr * $.properties; # properties list
    has xmlNs * $.nsDef; # namespace definitions on this node
    has Pointer $.psvi; # for type/PSVI informations
    has unsigned short $.line; # line number
    has unsigned short $.extra; # extra data for XPath/XSLT
}

struct xmlNotation is repr('CStruct') {
    has xmlCharP $.name; # Notation name
    has xmlCharP $.PublicID; # Public identifier, if any
    has xmlCharP $.SystemID; # System identifier, if any
}

struct xmlNs is repr('CStruct') {
    has struct _xmlNs * $.next; # next Ns link for this node
    has xmlNsType $.type; # global or local
    has xmlCharP $.href; # URL for the namespace
    has xmlCharP $.prefix; # prefix for the namespace
    has Pointer $._private; # application data
    has struct _xmlDoc * $.context; # normally an xmlDoc
}

struct xmlOutputBuffer is repr('CStruct') {
    has Pointer $.context;
    has xmlOutputWriteCallback $.writecallback;
    has xmlOutputCloseCallback $.closecallback;
    has xmlCharEncodingHandlerPtr $.encoder; # I18N conversions to UTF-8
    has xmlBufPtr $.buffer; # Local buffer encoded in UTF-8 or ISOLatin
    has xmlBufPtr $.conv; # if encoder != NULL buffer for output
    has int32 $.written; # total number of byte written
    has int32 $.error;
}

struct xmlParserCtxt is repr('CStruct') {
    has struct _xmlSAXHandler * $.sax; # The SAX handler
    has Pointer $.userData; # For SAX interface only, used by DOM build
    has xmlDocPtr $.myDoc; # the document being built
    has int32 $.wellFormed; # is the document well formed
    has int32 $.replaceEntities; # shall we replace entities ?
    has xmlCharP $.version; # the XML version string
    has xmlCharP $.encoding; # the declared encoding, if any
    has int32 $.standalone; # standalone document
    has int32 $.html; # an HTML(1)/Docbook(2) document * 3 is HTML after <head> * 10 is HTML after <body> * Input stream stack
    has xmlParserInputPtr $.input; # Current input stream
    has int32 $.inputNr; # Number of current input streams
    has int32 $.inputMax; # Max number of input streams
    has xmlParserInputPtr * $.inputTab; # stack of inputs Node analysis stack only used for DOM building
    has xmlNodePtr $.node; # Current parsed Node
    has int32 $.nodeNr; # Depth of the parsing stack
    has int32 $.nodeMax; # Max depth of the parsing stack
    has xmlNodePtr * $.nodeTab; # array of nodes
    has int32 $.record_info; # Whether node info should be kept
    has xmlParserNodeInfoSeq $.node_seq; # info about each node parsed
    has int32 $.errNo; # error code
    has int32 $.hasExternalSubset; # reference and external subset
    has int32 $.hasPErefs; # the internal subset has PE refs
    has int32 $.external; # are we parsing an external entity
    has int32 $.valid; # is the document valid
    has int32 $.validate; # shall we try to validate ?
    has xmlValidCtxt $.vctxt; # The validity context
    has xmlParserInputState $.instate; # current type of input
    has int32 $.token; # next char look-ahead
    has Str $.directory; # the data directory Node name stack
    has xmlCharP $.name; # Current parsed Node
    has int32 $.nameNr; # Depth of the parsing stack
    has int32 $.nameMax; # Max depth of the parsing stack
    has Pointer[xmlCharP] $.nameTab; # array of nodes
    has long $.nbChars; # number of xmlChar processed
    has long $.checkIndex; # used by progressive parsing lookup
    has int32 $.keepBlanks; # ugly but ...
    has int32 $.disableSAX; # SAX callbacks are disabled
    has int32 $.inSubset; # Parsing is in int 1/ext 2 subset
    has xmlCharP $.intSubName; # name of subset
    has xmlCharP $.extSubURI; # URI of external subset
    has xmlCharP $.extSubSystem; # SYSTEM ID of external subset xml:space values
    has Pointer[int32] $.space; # Should the parser preserve spaces
    has int32 $.spaceNr; # Depth of the parsing stack
    has int32 $.spaceMax; # Max depth of the parsing stack
    has Pointer[int32] $.spaceTab; # array of space infos
    has int32 $.depth; # to prevent entity substitution loops
    has xmlParserInputPtr $.entity; # used to check entities boundaries
    has int32 $.charset; # encoding of the in-memory content actually an xmlCharEncoding
    has int32 $.nodelen; # Those two fields are there to
    has int32 $.nodemem; # Speed up large node parsing
    has int32 $.pedantic; # signal pedantic warnings
    has Pointer $._private; # For user data, libxml won't touch it
    has int32 $.loadsubset; # should the external subset be loaded
    has int32 $.linenumbers; # set line number in element content
    has Pointer $.catalogs; # document's own catalog
    has int32 $.recovery; # run in recovery mode
    has int32 $.progressive; # is this a progressive parsing
    has xmlDictPtr $.dict; # dictionary for the parser
    has Pointer[xmlCharP] $.atts; # array for the attributes callbacks
    has int32 $.maxatts; # the size of the array
    has int32 $.docdict; # * pre-interned strings *
    has xmlCharP $.str_xml;
    has xmlCharP $.str_xmlns;
    has xmlCharP $.str_xml_ns; # * Everything below is used only by the new SAX mode *
    has int32 $.sax2; # operating in the new SAX mode
    has int32 $.nsNr; # the number of inherited namespaces
    has int32 $.nsMax; # the size of the arrays
    has Pointer[xmlCharP] $.nsTab; # the array of prefix/namespace name
    has Pointer[int32] $.attallocs; # which attribute were allocated
    has Pointer[Pointer] $.pushTab; # array of data for push
    has xmlHashTablePtr $.attsDefault; # defaulted attributes if any
    has xmlHashTablePtr $.attsSpecial; # non-CDATA attributes if any
    has int32 $.nsWellFormed; # is the document XML Nanespace okay
    has int32 $.options; # * Those fields are needed only for treaming parsing so far *
    has int32 $.dictNames; # Use dictionary names for the tree
    has int32 $.freeElemsNr; # number of freed element nodes
    has xmlNodePtr $.freeElems; # List of freed element nodes
    has int32 $.freeAttrsNr; # number of freed attributes nodes
    has xmlAttrPtr $.freeAttrs; # * the complete error informations for the last error. *
    has xmlError $.lastError;
    has xmlParserMode $.parseMode; # the parser mode
    has unsigned long $.nbentities; # number of entities references
    has unsigned long $.sizeentities; # size of parsed entities for use by HTML non-recursive parser
    has xmlParserNodeInfo * $.nodeInfo; # Current NodeInfo
    has int32 $.nodeInfoNr; # Depth of the parsing stack
    has int32 $.nodeInfoMax; # Max depth of the parsing stack
    has xmlParserNodeInfo * $.nodeInfoTab; # array of nodeInfos
    has int32 $.input_id; # we need to label inputs
    has unsigned long $.sizeentcopy; # volume of entity copy
}

struct xmlParserInput is repr('CStruct') {
    has xmlParserInputBufferPtr $.buf; # UTF-8 encoded buffer
    has Str $.filename; # The file analyzed, if any
    has Str $.directory; # the directory/base of the file
    has xmlCharP $.base; # Base of the array to parse
    has xmlCharP $.cur; # Current char being parsed
    has xmlCharP $.end; # end of the array to parse
    has int32 $.length; # length if known
    has int32 $.line; # Current line
    has int32 $.col; # * NOTE: consumed is only tested for equality in the parser code, *       so even if there is an overflow this should not give troubles *       for parsing very large instances. *
    has unsigned long $.consumed; # How many xmlChars already consumed
    has xmlParserInputDeallocate $.free; # function to deallocate the base
    has xmlCharP $.encoding; # the encoding string for entity
    has xmlCharP $.version; # the version string for entity
    has int32 $.standalone; # Was that entity marked standalone
    has int32 $.id; # an unique identifier for the entity
}

struct xmlParserInputBuffer is repr('CStruct') {
    has Pointer $.context;
    has xmlInputReadCallback $.readcallback;
    has xmlInputCloseCallback $.closecallback;
    has xmlCharEncodingHandlerPtr $.encoder; # I18N conversions to UTF-8
    has xmlBufPtr $.buffer; # Local buffer encoded in UTF-8
    has xmlBufPtr $.raw; # if encoder != NULL buffer for raw input
    has int32 $.compressed; # -1=unknown, 0=not compressed, 1=compressed
    has int32 $.error;
    has unsigned long $.rawconsumed; # amount consumed from raw
}

struct xmlRef is repr('CStruct') {
    has struct _xmlRef * $.next; # next Ref
    has xmlCharP $.value; # The Ref name
    has xmlAttrPtr $.attr; # The attribute holding it
    has xmlCharP $.name; # The attribute if attr is not available
    has int32 $.lineno; # The line number if attr is not available
}

struct xmlSAXHandler is repr('CStruct') {
    has internalSubsetSAXFunc $.internalSubset;
    has isStandaloneSAXFunc $.isStandalone;
    has hasInternalSubsetSAXFunc $.hasInternalSubset;
    has hasExternalSubsetSAXFunc $.hasExternalSubset;
    has resolveEntitySAXFunc $.resolveEntity;
    has getEntitySAXFunc $.getEntity;
    has entityDeclSAXFunc $.entityDecl;
    has notationDeclSAXFunc $.notationDecl;
    has attributeDeclSAXFunc $.attributeDecl;
    has elementDeclSAXFunc $.elementDecl;
    has unparsedEntityDeclSAXFunc $.unparsedEntityDecl;
    has setDocumentLocatorSAXFunc $.setDocumentLocator;
    has startDocumentSAXFunc $.startDocument;
    has endDocumentSAXFunc $.endDocument;
    has startElementSAXFunc $.startElement;
    has endElementSAXFunc $.endElement;
    has referenceSAXFunc $.reference;
    has charactersSAXFunc $.characters;
    has ignorableWhitespaceSAXFunc $.ignorableWhitespace;
    has processingInstructionSAXFunc $.processingInstruction;
    has commentSAXFunc $.comment;
    has warningSAXFunc $.warning;
    has errorSAXFunc $.error;
    has fatalErrorSAXFunc $.fatalError; # unused error() get all the errors
    has getParameterEntitySAXFunc $.getParameterEntity;
    has cdataBlockSAXFunc $.cdataBlock;
    has externalSubsetSAXFunc $.externalSubset;
    has uint32 $.initialized; # The following fields are extensions available only on version 2
    has Pointer $._private;
    has startElementNsSAX2Func $.startElementNs;
    has endElementNsSAX2Func $.endElementNs;
    has xmlStructuredErrorFunc $.serror;
}

struct xmlSAXLocator is repr('CStruct') {
    has const xmlChar *(*getPublicId) $.getPublicId;
    has const xmlChar *(*getSystemId) $.getSystemId;
    has int(*getLineNumber) $.getLineNumber;
    has int(*getColumnNumber) $.getColumnNumber;
}

sub xmlAddChild(xmlNodePtr $parent, xmlNodePtr $cur --> xmlNodePtr) is native(LIB) {*};
sub xmlAddChildList(xmlNodePtr $parent, xmlNodePtr $cur --> xmlNodePtr) is native(LIB) {*};
sub xmlAddNextSibling(xmlNodePtr $cur, xmlNodePtr $elem --> xmlNodePtr) is native(LIB) {*};
sub xmlAddPrevSibling(xmlNodePtr $cur, xmlNodePtr $elem --> xmlNodePtr) is native(LIB) {*};
sub xmlAddSibling(xmlNodePtr $cur, xmlNodePtr $elem --> xmlNodePtr) is native(LIB) {*};
sub xmlAttrSerializeTxtContent(xmlBufferPtr $buf, xmlDocPtr $doc, xmlAttrPtr $attr, xmlCharP $string) is native(LIB) {*};
sub xmlBufContent(const xmlBuf * $buf --> xmlCharP) is native(LIB) {*};
sub xmlBufEnd(xmlBufPtr $buf --> xmlCharP) is native(LIB) {*};
sub xmlBufGetNodeContent(xmlBufPtr $buf, const xmlNode * $cur --> int32) is native(LIB) {*};
sub xmlBufNodeDump(xmlBufPtr $buf, xmlDocPtr $doc, xmlNodePtr $cur, int32 $level, int32 $format --> size_t) is native(LIB) {*};
sub xmlBufShrink(xmlBufPtr $buf, size_t $len --> size_t) is native(LIB) {*};
sub xmlBufUse(const xmlBufPtr $buf --> size_t) is native(LIB) {*};
sub xmlBufferAdd(xmlBufferPtr $buf, xmlCharP $str, int32 $len --> int32) is native(LIB) {*};
sub xmlBufferAddHead(xmlBufferPtr $buf, xmlCharP $str, int32 $len --> int32) is native(LIB) {*};
sub xmlBufferCCat(xmlBufferPtr $buf, Str $str --> int32) is native(LIB) {*};
sub xmlBufferCat(xmlBufferPtr $buf, xmlCharP $str --> int32) is native(LIB) {*};
sub xmlBufferContent(const xmlBuffer * $buf --> xmlCharP) is native(LIB) {*};
sub xmlBufferCreate( --> xmlBufferPtr) is native(LIB) {*};
sub xmlBufferCreateSize(size_t $size --> xmlBufferPtr) is native(LIB) {*};
sub xmlBufferCreateStatic(Pointer $mem, size_t $size --> xmlBufferPtr) is native(LIB) {*};
sub xmlBufferDetach(xmlBufferPtr $buf --> xmlCharP) is native(LIB) {*};
sub xmlBufferDump(FILE * $file, xmlBufferPtr $buf --> int32) is native(LIB) {*};
sub xmlBufferEmpty(xmlBufferPtr $buf) is native(LIB) {*};
sub xmlBufferFree(xmlBufferPtr $buf) is native(LIB) {*};
sub xmlBufferGrow(xmlBufferPtr $buf, uint32 $len --> int32) is native(LIB) {*};
sub xmlBufferLength(const xmlBuffer * $buf --> int32) is native(LIB) {*};
sub xmlBufferResize(xmlBufferPtr $buf, uint32 $size --> int32) is native(LIB) {*};
sub xmlBufferSetAllocationScheme(xmlBufferPtr $buf, xmlBufferAllocationScheme $scheme) is native(LIB) {*};
sub xmlBufferShrink(xmlBufferPtr $buf, uint32 $len --> int32) is native(LIB) {*};
sub xmlBufferWriteCHAR(xmlBufferPtr $buf, xmlCharP $string) is native(LIB) {*};
sub xmlBufferWriteChar(xmlBufferPtr $buf, Str $string) is native(LIB) {*};
sub xmlBufferWriteQuotedString(xmlBufferPtr $buf, xmlCharP $string) is native(LIB) {*};
sub xmlBuildQName(xmlCharP $ncname, xmlCharP $prefix, xmlCharP $memory, int32 $len --> xmlCharP) is native(LIB) {*};
sub xmlChildElementCount(xmlNodePtr $parent --> unsigned long) is native(LIB) {*};
sub xmlCopyDoc(xmlDocPtr $doc, int32 $recursive --> xmlDocPtr) is native(LIB) {*};
sub xmlCopyDtd(xmlDtdPtr $dtd --> xmlDtdPtr) is native(LIB) {*};
sub xmlCopyNamespace(xmlNsPtr $cur --> xmlNsPtr) is native(LIB) {*};
sub xmlCopyNamespaceList(xmlNsPtr $cur --> xmlNsPtr) is native(LIB) {*};
sub xmlCopyNode(xmlNodePtr $node, int32 $extended --> xmlNodePtr) is native(LIB) {*};
sub xmlCopyNodeList(xmlNodePtr $node --> xmlNodePtr) is native(LIB) {*};
sub xmlCopyProp(xmlNodePtr $target, xmlAttrPtr $cur --> xmlAttrPtr) is native(LIB) {*};
sub xmlCopyPropList(xmlNodePtr $target, xmlAttrPtr $cur --> xmlAttrPtr) is native(LIB) {*};
sub xmlCreateIntSubset(xmlDocPtr $doc, xmlCharP $name, xmlCharP $ExternalID, xmlCharP $SystemID --> xmlDtdPtr) is native(LIB) {*};
sub xmlDOMWrapAdoptNode(xmlDOMWrapCtxtPtr $ctxt, xmlDocPtr $sourceDoc, xmlNodePtr $node, xmlDocPtr $destDoc, xmlNodePtr $destParent, int32 $options --> int32) is native(LIB) {*};
sub xmlDOMWrapCloneNode(xmlDOMWrapCtxtPtr $ctxt, xmlDocPtr $sourceDoc, xmlNodePtr $node, xmlNodePtr * $resNode, xmlDocPtr $destDoc, xmlNodePtr $destParent, int32 $deep, int32 $options --> int32) is native(LIB) {*};
sub xmlDOMWrapFreeCtxt(xmlDOMWrapCtxtPtr $ctxt) is native(LIB) {*};
sub xmlDOMWrapNewCtxt( --> xmlDOMWrapCtxtPtr) is native(LIB) {*};
sub xmlDOMWrapReconcileNamespaces(xmlDOMWrapCtxtPtr $ctxt, xmlNodePtr $elem, int32 $options --> int32) is native(LIB) {*};
sub xmlDOMWrapRemoveNode(xmlDOMWrapCtxtPtr $ctxt, xmlDocPtr $doc, xmlNodePtr $node, int32 $options --> int32) is native(LIB) {*};
sub xmlDocCopyNode(xmlNodePtr $node, xmlDocPtr $doc, int32 $extended --> xmlNodePtr) is native(LIB) {*};
sub xmlDocCopyNodeList(xmlDocPtr $doc, xmlNodePtr $node --> xmlNodePtr) is native(LIB) {*};
sub xmlDocDump(FILE * $f, xmlDocPtr $cur --> int32) is native(LIB) {*};
sub xmlDocDumpFormatMemory(xmlDocPtr $cur, xmlChar ** $mem, Pointer[int32] $size, int32 $format) is native(LIB) {*};
sub xmlDocDumpFormatMemoryEnc(xmlDocPtr $out_doc, xmlChar ** $doc_txt_ptr, Pointer[int32] $doc_txt_len, Str $txt_encoding, int32 $format) is native(LIB) {*};
sub xmlDocDumpMemory(xmlDocPtr $cur, xmlChar ** $mem, Pointer[int32] $size) is native(LIB) {*};
sub xmlDocDumpMemoryEnc(xmlDocPtr $out_doc, xmlChar ** $doc_txt_ptr, Pointer[int32] $doc_txt_len, Str $txt_encoding) is native(LIB) {*};
sub xmlDocFormatDump(FILE * $f, xmlDocPtr $cur, int32 $format --> int32) is native(LIB) {*};
sub xmlDocGetRootElement(const xmlDoc * $doc --> xmlNodePtr) is native(LIB) {*};
sub xmlDocSetRootElement(xmlDocPtr $doc, xmlNodePtr $root --> xmlNodePtr) is native(LIB) {*};
sub xmlElemDump(FILE * $f, xmlDocPtr $doc, xmlNodePtr $cur) is native(LIB) {*};
sub xmlFirstElementChild(xmlNodePtr $parent --> xmlNodePtr) is native(LIB) {*};
sub xmlFreeDoc(xmlDocPtr $cur) is native(LIB) {*};
sub xmlFreeDtd(xmlDtdPtr $cur) is native(LIB) {*};
sub xmlFreeNode(xmlNodePtr $cur) is native(LIB) {*};
sub xmlFreeNodeList(xmlNodePtr $cur) is native(LIB) {*};
sub xmlFreeNs(xmlNsPtr $cur) is native(LIB) {*};
sub xmlFreeNsList(xmlNsPtr $cur) is native(LIB) {*};
sub xmlFreeProp(xmlAttrPtr $cur) is native(LIB) {*};
sub xmlFreePropList(xmlAttrPtr $cur) is native(LIB) {*};
sub xmlGetBufferAllocationScheme( --> xmlBufferAllocationScheme) is native(LIB) {*};
sub xmlGetCompressMode( --> int32) is native(LIB) {*};
sub xmlGetDocCompressMode(const xmlDoc * $doc --> int32) is native(LIB) {*};
sub xmlGetIntSubset(const xmlDoc * $doc --> xmlDtdPtr) is native(LIB) {*};
sub xmlGetLastChild(const xmlNode * $parent --> xmlNodePtr) is native(LIB) {*};
sub xmlGetLineNo(const xmlNode * $node --> long) is native(LIB) {*};
sub xmlGetNoNsProp(const xmlNode * $node, xmlCharP $name --> xmlCharP) is native(LIB) {*};
sub xmlGetNodePath(const xmlNode * $node --> xmlCharP) is native(LIB) {*};
sub xmlGetNsList(const xmlDoc * $doc, const xmlNode * $node --> xmlNsPtr *) is native(LIB) {*};
sub xmlGetNsProp(const xmlNode * $node, xmlCharP $name, xmlCharP $nameSpace --> xmlCharP) is native(LIB) {*};
sub xmlGetProp(const xmlNode * $node, xmlCharP $name --> xmlCharP) is native(LIB) {*};
sub xmlHasNsProp(const xmlNode * $node, xmlCharP $name, xmlCharP $nameSpace --> xmlAttrPtr) is native(LIB) {*};
sub xmlHasProp(const xmlNode * $node, xmlCharP $name --> xmlAttrPtr) is native(LIB) {*};
sub xmlIsBlankNode(const xmlNode * $node --> int32) is native(LIB) {*};
sub xmlIsXHTML(xmlCharP $systemID, xmlCharP $publicID --> int32) is native(LIB) {*};
sub xmlLastElementChild(xmlNodePtr $parent --> xmlNodePtr) is native(LIB) {*};
sub xmlNewCDataBlock(xmlDocPtr $doc, xmlCharP $content, int32 $len --> xmlNodePtr) is native(LIB) {*};
sub xmlNewCharRef(xmlDocPtr $doc, xmlCharP $name --> xmlNodePtr) is native(LIB) {*};
sub xmlNewChild(xmlNodePtr $parent, xmlNsPtr $ns, xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewComment(xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDoc(xmlCharP $version --> xmlDocPtr) is native(LIB) {*};
sub xmlNewDocComment(xmlDocPtr $doc, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocFragment(xmlDocPtr $doc --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocNode(xmlDocPtr $doc, xmlNsPtr $ns, xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocNodeEatName(xmlDocPtr $doc, xmlNsPtr $ns, xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocPI(xmlDocPtr $doc, xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocProp(xmlDocPtr $doc, xmlCharP $name, xmlCharP $value --> xmlAttrPtr) is native(LIB) {*};
sub xmlNewDocRawNode(xmlDocPtr $doc, xmlNsPtr $ns, xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocText(const xmlDoc * $doc, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDocTextLen(xmlDocPtr $doc, xmlCharP $content, int32 $len --> xmlNodePtr) is native(LIB) {*};
sub xmlNewDtd(xmlDocPtr $doc, xmlCharP $name, xmlCharP $ExternalID, xmlCharP $SystemID --> xmlDtdPtr) is native(LIB) {*};
sub xmlNewGlobalNs(xmlDocPtr $doc, xmlCharP $href, xmlCharP $prefix --> xmlNsPtr) is native(LIB) {*};
sub xmlNewNode(xmlNsPtr $ns, xmlCharP $name --> xmlNodePtr) is native(LIB) {*};
sub xmlNewNodeEatName(xmlNsPtr $ns, xmlCharP $name --> xmlNodePtr) is native(LIB) {*};
sub xmlNewNs(xmlNodePtr $node, xmlCharP $href, xmlCharP $prefix --> xmlNsPtr) is native(LIB) {*};
sub xmlNewNsProp(xmlNodePtr $node, xmlNsPtr $ns, xmlCharP $name, xmlCharP $value --> xmlAttrPtr) is native(LIB) {*};
sub xmlNewNsPropEatName(xmlNodePtr $node, xmlNsPtr $ns, xmlCharP $name, xmlCharP $value --> xmlAttrPtr) is native(LIB) {*};
sub xmlNewPI(xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewProp(xmlNodePtr $node, xmlCharP $name, xmlCharP $value --> xmlAttrPtr) is native(LIB) {*};
sub xmlNewReference(const xmlDoc * $doc, xmlCharP $name --> xmlNodePtr) is native(LIB) {*};
sub xmlNewText(xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewTextChild(xmlNodePtr $parent, xmlNsPtr $ns, xmlCharP $name, xmlCharP $content --> xmlNodePtr) is native(LIB) {*};
sub xmlNewTextLen(xmlCharP $content, int32 $len --> xmlNodePtr) is native(LIB) {*};
sub xmlNextElementSibling(xmlNodePtr $node --> xmlNodePtr) is native(LIB) {*};
sub xmlNodeAddContent(xmlNodePtr $cur, xmlCharP $content) is native(LIB) {*};
sub xmlNodeAddContentLen(xmlNodePtr $cur, xmlCharP $content, int32 $len) is native(LIB) {*};
sub xmlNodeBufGetContent(xmlBufferPtr $buffer, const xmlNode * $cur --> int32) is native(LIB) {*};
sub xmlNodeDump(xmlBufferPtr $buf, xmlDocPtr $doc, xmlNodePtr $cur, int32 $level, int32 $format --> int32) is native(LIB) {*};
sub xmlNodeDumpOutput(xmlOutputBufferPtr $buf, xmlDocPtr $doc, xmlNodePtr $cur, int32 $level, int32 $format, Str $encoding) is native(LIB) {*};
sub xmlNodeGetBase(const xmlDoc * $doc, const xmlNode * $cur --> xmlCharP) is native(LIB) {*};
sub xmlNodeGetContent(const xmlNode * $cur --> xmlCharP) is native(LIB) {*};
sub xmlNodeGetLang(const xmlNode * $cur --> xmlCharP) is native(LIB) {*};
sub xmlNodeGetSpacePreserve(const xmlNode * $cur --> int32) is native(LIB) {*};
sub xmlNodeIsText(const xmlNode * $node --> int32) is native(LIB) {*};
sub xmlNodeListGetRawString(const xmlDoc * $doc, const xmlNode * $list, int32 $inLine --> xmlCharP) is native(LIB) {*};
sub xmlNodeListGetString(xmlDocPtr $doc, const xmlNode * $list, int32 $inLine --> xmlCharP) is native(LIB) {*};
sub xmlNodeSetBase(xmlNodePtr $cur, xmlCharP $uri) is native(LIB) {*};
sub xmlNodeSetContent(xmlNodePtr $cur, xmlCharP $content) is native(LIB) {*};
sub xmlNodeSetContentLen(xmlNodePtr $cur, xmlCharP $content, int32 $len) is native(LIB) {*};
sub xmlNodeSetLang(xmlNodePtr $cur, xmlCharP $lang) is native(LIB) {*};
sub xmlNodeSetName(xmlNodePtr $cur, xmlCharP $name) is native(LIB) {*};
sub xmlNodeSetSpacePreserve(xmlNodePtr $cur, int32 $val) is native(LIB) {*};
sub xmlPreviousElementSibling(xmlNodePtr $node --> xmlNodePtr) is native(LIB) {*};
sub xmlReconciliateNs(xmlDocPtr $doc, xmlNodePtr $tree --> int32) is native(LIB) {*};
sub xmlRemoveProp(xmlAttrPtr $cur --> int32) is native(LIB) {*};
sub xmlReplaceNode(xmlNodePtr $old, xmlNodePtr $cur --> xmlNodePtr) is native(LIB) {*};
sub xmlSaveFile(Str $filename, xmlDocPtr $cur --> int32) is native(LIB) {*};
sub xmlSaveFileEnc(Str $filename, xmlDocPtr $cur, Str $encoding --> int32) is native(LIB) {*};
sub xmlSaveFileTo(xmlOutputBufferPtr $buf, xmlDocPtr $cur, Str $encoding --> int32) is native(LIB) {*};
sub xmlSaveFormatFile(Str $filename, xmlDocPtr $cur, int32 $format --> int32) is native(LIB) {*};
sub xmlSaveFormatFileEnc(Str $filename, xmlDocPtr $cur, Str $encoding, int32 $format --> int32) is native(LIB) {*};
sub xmlSaveFormatFileTo(xmlOutputBufferPtr $buf, xmlDocPtr $cur, Str $encoding, int32 $format --> int32) is native(LIB) {*};
sub xmlSearchNs(xmlDocPtr $doc, xmlNodePtr $node, xmlCharP $nameSpace --> xmlNsPtr) is native(LIB) {*};
sub xmlSearchNsByHref(xmlDocPtr $doc, xmlNodePtr $node, xmlCharP $href --> xmlNsPtr) is native(LIB) {*};
sub xmlSetBufferAllocationScheme(xmlBufferAllocationScheme $scheme) is native(LIB) {*};
sub xmlSetCompressMode(int32 $mode) is native(LIB) {*};
sub xmlSetDocCompressMode(xmlDocPtr $doc, int32 $mode) is native(LIB) {*};
sub xmlSetListDoc(xmlNodePtr $list, xmlDocPtr $doc) is native(LIB) {*};
sub xmlSetNs(xmlNodePtr $node, xmlNsPtr $ns) is native(LIB) {*};
sub xmlSetNsProp(xmlNodePtr $node, xmlNsPtr $ns, xmlCharP $name, xmlCharP $value --> xmlAttrPtr) is native(LIB) {*};
sub xmlSetProp(xmlNodePtr $node, xmlCharP $name, xmlCharP $value --> xmlAttrPtr) is native(LIB) {*};
sub xmlSetTreeDoc(xmlNodePtr $tree, xmlDocPtr $doc) is native(LIB) {*};
sub xmlSplitQName2(xmlCharP $name, xmlChar ** $prefix --> xmlCharP) is native(LIB) {*};
sub xmlSplitQName3(xmlCharP $name, Pointer[int32] $len --> xmlCharP) is native(LIB) {*};
sub xmlStringGetNodeList(const xmlDoc * $doc, xmlCharP $value --> xmlNodePtr) is native(LIB) {*};
sub xmlStringLenGetNodeList(const xmlDoc * $doc, xmlCharP $value, int32 $len --> xmlNodePtr) is native(LIB) {*};
sub xmlTextConcat(xmlNodePtr $node, xmlCharP $content, int32 $len --> int32) is native(LIB) {*};
sub xmlTextMerge(xmlNodePtr $first, xmlNodePtr $second --> xmlNodePtr) is native(LIB) {*};
sub xmlUnlinkNode(xmlNodePtr $cur) is native(LIB) {*};
sub xmlUnsetNsProp(xmlNodePtr $node, xmlNsPtr $ns, xmlCharP $name --> int32) is native(LIB) {*};
sub xmlUnsetProp(xmlNodePtr $node, xmlCharP $name --> int32) is native(LIB) {*};
sub xmlValidateNCName(xmlCharP $value, int32 $space --> int32) is native(LIB) {*};
sub xmlValidateNMToken(xmlCharP $value, int32 $space --> int32) is native(LIB) {*};
sub xmlValidateName(xmlCharP $value, int32 $space --> int32) is native(LIB) {*};
sub xmlValidateQName(xmlCharP $value, int32 $space --> int32) is native(LIB) {*};