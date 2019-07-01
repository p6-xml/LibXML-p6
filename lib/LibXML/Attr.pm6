use LibXML::Node;

unit class LibXML::Attr
    is LibXML::Node;

use LibXML::Native;
use LibXML::Types :QName;
use Method::Also;

multi submethod TWEAK(LibXML::Node :doc($)!, xmlAttr:D :native($)!) {
}
multi submethod TWEAK(LibXML::Node :doc($doc-obj), QName:D :$name!, Str :$value!) {
    my xmlDoc $doc = .native with $doc-obj;
    self.native = xmlAttr.new: :$name, :$value, :$doc;
}

method native handles <atype isId name serializeContent> {
    nextsame;
}

method value is rw { $.nodeValue }

method Str is also<getValue> { $.nodeValue}
method setValue(Str $_) { $.nodeValue = $_ }
method gist(|c) { $.native.Str(|c) }

=begin pod

=head1 NAME

LibXML::Attr - LibXML Attribute Class

=head1 SYNOPSIS



  use LibXML::Attr;
  # Only methods specific to Attribute nodes are listed here,
  # see the LibXML::Node manpage for other methods

  my LibXML::Attr $attr .= new(:$name, :$value);
  my Str $value = $attr.getValue();
  $value = $attr.value;
  $attr.setValue( $string );
  $att.value = $string;
  my LibXML::Node $node = $attr.getOwnerElement();
  $attr.setNamespace($nsURI, $prefix);
  my Bool $is-id = $attr.isId;
  my Str $content = $attr.serializeContent;

=head1 DESCRIPTION

This is the interface to handle Attributes like ordinary nodes. The naming of
the class relies on the W3C DOM documentation.


=head1 METHODS

The class inherits from L<<<<<< LibXML::Node >>>>>>. The documentation for Inherited methods is not listed here.

Many functions listed here are extensively documented in the DOM Level 3 specification (L<<<<<< http://www.w3.org/TR/DOM-Level-3-Core/ >>>>>>). Please refer to the specification for extensive documentation.

=begin item
new

  my LibXML::Attr $attr .= new($name [,$value]);

Class constructor. If you need to work with ISO encoded strings, you should I<<<<<< always >>>>>> use the C<<<<<< createAttribute >>>>>> of L<<<<<< LibXML::Document >>>>>>.
=end item

=begin item
getValue

  my Str $val = $attr.getValue();

Returns the value stored for the attribute. If undef is returned, the attribute
has no value, which is different of being C<<<<<< not specified >>>>>>.
=end item

=begin item
value

  my Str $val = $attr.value;

Alias for I<<<<<< getValue() >>>>>>
=end item

=begin item
setValue

  $attr.setValue( $string );

This is needed to set a new attribute value. If ISO encoded strings are passed
as parameter, the node has to be bound to a document, otherwise the encoding
might be done incorrectly.
=end item

=begin item
getOwnerElement

  my LibXML::Node $owner = $attr.getOwnerElement();

returns the node the attribute belongs to. If the attribute is not bound to a
node, undef will be returned. Overwriting the underlying implementation, the I<<<<<< parentNode >>>>>> function will return undef, instead of the owner element.
=end item

=begin item
setNamespace

  $attr.setNamespace($nsURI, $prefix);

This function tries to bound the attribute to a given namespace. If C<<<<<< $nsURI >>>>>> is undefined or empty, the function discards any previous association of the
attribute with a namespace. If the namespace was not previously declared in the
context of the attribute, this function will fail. In this case you may wish to
call setNamespace() on the ownerElement. If the namespace URI is non-empty and
declared in the context of the attribute, but only with a different (non-empty)
prefix, then the attribute is still bound to the namespace but gets a different
prefix than C<<<<<< $prefix >>>>>>. The function also fails if the prefix is empty but the namespace URI is not
(because unprefixed attributes should by definition belong to no namespace).
This function returns 1 on success, 0 otherwise.
=end item

=begin item
isId

  my Bool $yup = $attr.isId;

Determine whether an attribute is of type ID. For documents with a DTD, this
information is only available if DTD loading/validation has been requested. For
HTML documents parsed with the HTML parser ID detection is done automatically.
In XML documents, all "xml:id" attributes are considered to be of type ID.
=end item

=begin item
serializeContent

  my Str $content = $attr.serializeContent;

This function is not part of DOM API. It returns attribute content in the form
in which it serializes into XML, that is with all meta-characters properly
quoted and with raw entity references (except for entities expanded during
parse time).

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

=cut


=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=end pod
