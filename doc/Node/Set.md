NAME
====

LibXML::Node::Set - LibXML Class for Node Collections

SYNOPSIS
========

    use LibXML::Node::Set;
    my LibXML::Node::Set $node-set;

    $node-set = $elem.childNodes;
    $node-set = $elem.findnodes($xpath);
    $node-set .= new;
    $node-set.push: $elem;

    for $node-set -> LibXML::Item $item { ... }
    for 0 ..^ $node-set.elems { my $item = $node-set[$_]; ... }

    my LibXML::Node::Set %nodes-by-tag-name = $node-set.Hash;
    ...

DESCRIPTION
-----------

This is a positional class, commonlu used for handling results from XPath queries.
