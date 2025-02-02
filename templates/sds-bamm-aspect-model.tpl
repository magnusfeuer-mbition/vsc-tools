{% import 'sds-bamm-macros.tpl' as bamm %}

{% set aspectModelURN = item.children[0].name %}
{% set aspectModelVersion = item.children[0].major_version ~ '.' ~ item.children[0].minor_version ~ '.0' %}

@prefix: <urn:bamm:{{ aspectModelURN }}:{{ aspectModelVersion }}#>.
@prefix bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#> .
@prefix bamm-c: <urn:bamm:io.openmanufacturing:characteristic:1.0.0#> .
@prefix bamm-e: <urn:bamm:io.openmanufacturing:entity:1.0.0#> .
@prefix unit: <urn:bamm:io.openmanufacturing:unit:1.0.0#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

{%for s in item.children %}

    {# --- Aspect --- #}

    {% for n in s.namespaces -%}
    {{ bamm.render_aspect(n) }}

    {# --- Operations --- #}

    {% for method in n.methods -%}
    {{ bamm.render_operation(method) }}
    {% endfor %}

    {# --- Events --- #}

    {%- for event in n.events -%}
    {{ bamm.render_event(event) }}
    {% endfor %}

    {# --- Entities --- #}

    {%- for struct in n.structs -%}
    {{ bamm.render_entity(struct) }}
    {% endfor %}

    {# --- Properties --- #}

    {%- for struct in n.structs -%}
    {%- for member in struct.members -%}
    {{ bamm.render_property(member) }}
    {% endfor %}
    {% endfor %}

    {%- for event in n.events -%}
    {%- for in_arg in event.in -%}
    {{ bamm.render_property(in_arg) }}
    {% endfor %}
    {% endfor %}

    {%- for method in n.methods -%}
    {%- for inProp in method.in -%}
    {{ bamm.render_property(inProp) }}
    {% endfor %}
    {%- for outProp in method.out -%}
    {{ bamm.render_property(outProp) }}
    {% endfor %}
    {% endfor %}

    {# --- Characteristics --- #}

    {%- for typedef in n.typedefs -%}
    {{ bamm.render_characteristic(typedef) }}
    {% endfor %}

    {%- for enum in n.enumerations -%}
    {{ bamm.render_enumeration(enum) }}
    {% endfor %}

    {%- for struct in n.structs -%}
    {%- for member in struct.members -%}
    {{ bamm.render_characteristic(member) }}
    {% endfor %}
    {% endfor %}

    {%- for event in n.events -%}
    {%- for in_arg in event.in -%}
    {{ bamm.render_characteristic(in_arg) }}
    {% endfor %}
    {% endfor %}

    {%- for method in n.methods -%}
    {%- for inProp in method.in -%}
    {{ bamm.render_characteristic(inProp) }}
    {% endfor %}
    {%- for outProp in method.out -%}
    {{ bamm.render_characteristic(outProp) }}
    {% endfor %}
    {% endfor %}

    {% endfor %}
{% endfor %}
