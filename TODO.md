* Fix duplication in `registers_metamodel_from_emfatic.rb`
* Update HTML views for transformations and instances with latest attributes (see db/schema.rb)
* Don't leak Java exceptions into @instance.error; instead catch Java exceptions and re-throw as exceptions specific to this service.