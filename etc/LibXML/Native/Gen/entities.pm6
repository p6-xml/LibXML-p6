use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::entities;
# interface for the XML entities handling:
#    this module provides some of the entity API needed for the parser and applications. 
use LibXML::Native::Defs :LIB, :XmlCharP;

enum xmlEntityType is export {
    XML_EXTERNAL_GENERAL_PARSED_ENTITY => 2,
    XML_EXTERNAL_GENERAL_UNPARSED_ENTITY => 3,
    XML_EXTERNAL_PARAMETER_ENTITY => 5,
    XML_INTERNAL_GENERAL_ENTITY => 1,
    XML_INTERNAL_PARAMETER_ENTITY => 4,
    XML_INTERNAL_PREDEFINED_ENTITY => 6,
}

struct xmlEntitiesTable is repr('CPointer') {
}

sub xmlAddDocEntity(xmlDocPtr $doc, xmlCharP $name, int32 $type, xmlCharP $ExternalID, xmlCharP $SystemID, xmlCharP $content --> xmlEntityPtr) is native(LIB) {*};
sub xmlAddDtdEntity(xmlDocPtr $doc, xmlCharP $name, int32 $type, xmlCharP $ExternalID, xmlCharP $SystemID, xmlCharP $content --> xmlEntityPtr) is native(LIB) {*};
sub xmlCleanupPredefinedEntities() is native(LIB) {*};
sub xmlCopyEntitiesTable(xmlEntitiesTablePtr $table --> xmlEntitiesTablePtr) is native(LIB) {*};
sub xmlCreateEntitiesTable( --> xmlEntitiesTablePtr) is native(LIB) {*};
sub xmlDumpEntitiesTable(xmlBufferPtr $buf, xmlEntitiesTablePtr $table) is native(LIB) {*};
sub xmlDumpEntityDecl(xmlBufferPtr $buf, xmlEntityPtr $ent) is native(LIB) {*};
sub xmlEncodeEntities(xmlDocPtr $doc, xmlCharP $input --> xmlCharP) is native(LIB) {*};
sub xmlEncodeEntitiesReentrant(xmlDocPtr $doc, xmlCharP $input --> xmlCharP) is native(LIB) {*};
sub xmlEncodeSpecialChars(const xmlDoc * $doc, xmlCharP $input --> xmlCharP) is native(LIB) {*};
sub xmlFreeEntitiesTable(xmlEntitiesTablePtr $table) is native(LIB) {*};
sub xmlGetDocEntity(const xmlDoc * $doc, xmlCharP $name --> xmlEntityPtr) is native(LIB) {*};
sub xmlGetDtdEntity(xmlDocPtr $doc, xmlCharP $name --> xmlEntityPtr) is native(LIB) {*};
sub xmlGetParameterEntity(xmlDocPtr $doc, xmlCharP $name --> xmlEntityPtr) is native(LIB) {*};
sub xmlGetPredefinedEntity(xmlCharP $name --> xmlEntityPtr) is native(LIB) {*};
sub xmlInitializePredefinedEntities() is native(LIB) {*};
sub xmlNewEntity(xmlDocPtr $doc, xmlCharP $name, int32 $type, xmlCharP $ExternalID, xmlCharP $SystemID, xmlCharP $content --> xmlEntityPtr) is native(LIB) {*};