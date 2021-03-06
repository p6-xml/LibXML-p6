[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML Module]](https://libxml-raku.github.io/LibXML-raku)
 / [Enums](https://libxml-raku.github.io/LibXML-raku/Enums)

module LibXML::Enums
--------------------

Native enumerations

Description
-----------

The Lib::XML::Enums module exports a large number of libxml2 native enumerations.

All are prefixed `XML_*`.

These are mostly low-level and encapsulated by LibXML. For example for nodes of type [LibXML::Element](https://libxml-raku.github.io/LibXML-raku/Element) always have a `type` of `XML_ELEMENT_NODE`.

The `code` attribute of X::LibXML exceptions (see [LibXML::ErrorHandling](https://libxml-raku.github.io/LibXML-raku/ErrorHandling)) may be useful, if you wish to detect various libxml errors, for example:

    use LibXML;
    use LibXML::Enums;

    try LibXML.parse: :string("<foo>42</bar>");
    with $! -> X::LibXML $err {
        if $err.code == XML_ERR_TAG_NAME_MISMATCH {
            warn "your tags don't match";
        }
        else {
            warn $err;
        }
    }

The libxml [error documentation](error documentation) lists possible error codes. Enumerations should be defined for all of these. 

License
-------

This program is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0 [http://www.perlfoundation.org/artistic_license_2_0](http://www.perlfoundation.org/artistic_license_2_0).

