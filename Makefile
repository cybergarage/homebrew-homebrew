.PHONY: update update-dry update-commit

# Update all formulae to the latest upstream Git tag
update:
	bash update.sh $(FORMULA)

# Show what would be updated without changing files
update-dry:
	bash update.sh -n $(FORMULA)

# Update and commit each formula
update-commit:
	bash update.sh -c $(FORMULA)
