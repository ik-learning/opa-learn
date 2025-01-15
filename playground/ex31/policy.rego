# METADATA
# title: My Example Package
# description: A set of rules illustrating how metadata annotations can be merged.
# authors:
# - John Doe <john@example.com>
# organizations:
# - Acme Corp.
package example

# https://www.openpolicyagent.org/docs/latest/policy-reference/
# opa eval --data playground/ex31 --format pretty 'data.example.allow'

# METADATA
# scope: document
# description: A rule that merges metadata annotations in various ways.

# METADATA
# title: My Allow Rule
# authors:
# - Jane Doe <jane@example.com>
allow if {
	meta := merge(rego.metadata.chain())
	meta.title == "My Allow Rule" # 'title' pulled from 'rule' scope
	meta.description == "A rule that merges metadata annotations in various ways." # 'description' pulled from 'document' scope
	meta.authors == {
		{"email": "jane@example.com", "name": "Jane Doe"}, # 'authors' joined from 'package' and 'rule' scopes
		{"email": "john@example.com", "name": "John Doe"},
	}
	meta.organizations == {"Acme Corp."} # 'organizations' pulled from 'package' scope
}

allow if {
	meta := merge(rego.metadata.chain())
	meta.title == null # No 'title' present in 'rule' or 'document' scopes
	meta.description == "A rule that merges metadata annotations in various ways." # 'description' pulled from 'document' scope
	meta.authors == { # 'authors' pulled from 'package' scope
		{"email": "john@example.com", "name": "John Doe"}
	}
	meta.organizations == {"Acme Corp."} # 'organizations' pulled from 'package' scope
}

merge(chain) := meta if {
    print(chain)
    output := opa.runtime()
    print("output:", output)
	ruleAndDoc := ["rule", "document"]
	meta := {
		"title": override_annot(chain, "title", ruleAndDoc), # looks for 'title' in 'rule' scope, then 'document' scope
		"description": override_annot(chain, "description", ruleAndDoc), # looks for 'description' in 'rule' scope, then 'document' scope
		"related_resources": override_annot(chain, "related_resources", ruleAndDoc), # looks for 'related_resources' in 'rule' scope, then 'document' scope
		"authors": merge_annot(chain, "authors"), # merges all 'authors' across all scopes
		"organizations": merge_annot(chain, "organizations"), # merges all 'organizations' across all scopes
	}
}

override_annot(chain, name, scopes) := val if {
	val := [v |
		link := chain[_]
		link.annotations.scope in scopes
		v := link.annotations[name]
	][0]
} else := null

merge_annot(chain, name) := val if {
	val := {v |
		v := chain[_].annotations[name][_]
	}
} else := null
