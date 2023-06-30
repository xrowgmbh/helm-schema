# JSON schemas for Helm

## Develop

Execute:

```bash
sh build.sh
```

Now do a change in the code or the schema and run the following command for testing:

```
helm lint schema-test/
```

## Creating a JSON Schema for existing YAML values

We can infer a schema from existing YAML values and use it as a starting point when writing a new schema. The steps are:

* Convert your values YAML file to JSON on https://www.json2yaml.com/
* Paste the JSON on https://www.jsonschema.net/ and click on "Infer Schema
* Paste the schema into the values.schema.json file