# Json Schemas for Helm

Develop:

See test job for build.

podman stop test || true
podman rm test || true
podman run -d -u root --name test -v $(pwd)/public/:/usr/local/apache2/htdocs/:z -p 443:443 test

helm lint schema-test/

## Creating a JSON Schema for existing YAML values

We can infer a schema from existing YAML values and use it as a starting point when writing a new schema. The steps are:

* Convert your values YAML file to JSON on https://www.json2yaml.com/
* Paste the JSON on https://www.jsonschema.net/ and click on "Infer Schema
* Paste the schema into the values.schema.json file