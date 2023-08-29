# Opa Learn

- [Open Policy Agent](https://www.openpolicyagent.org/)
- [OPA: Terraform](https://www.openpolicyagent.org/docs/v0.14.2/terraform/)
- [OPA&Rego: Playground](https://play.openpolicyagent.org/)
- [OPA: sources](https://github.com/open-policy-agent/opa)

---

![](https://img.shields.io/github/commit-activity/m/ik-learning/opa-learn)
![](https://img.shields.io/github/last-commit/ik-learning/opa-learn)
[![](https://img.shields.io/github/license/ivankatliarchuk/.github)](https://github.com/ivankatliarchuk/.github/LICENCE)
[![](https://img.shields.io/github/languages/code-size/ik-learning/opa-learn)](https://github.com/ik-learning/opa-learn)
[![](https://img.shields.io/github/repo-size/ik-learning/opa-learn)](https://github.com/ik-learning/opa-learn)
![](https://img.shields.io/github/languages/top/ik-learning/opa-learn?color=green&logo=markdown&logoColor=blue)

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

- [Commands](#commands)
- [Resources](#resources)
- [Create](#create)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

---

## Commands

```sh
mk tests num=1
mk tests num=2
mk tests num=3
mk tests num=4

1. terraform init
2. terraform plan --out tfplan.binary
3. terraform show -json tfplan.binary > tfplan.json
# command to find the score
4. opa eval --format pretty --data s3-validate.rego --input tfplan.json "data.terraform.analysis.score"
# command to find true / false flag.
5. opa eval --format pretty --data s3-validate.rego --input tfplan.json "data.terraform.analysis.authz"
# command to get list of errors, in this scenario you have to provide the rego file name as well
6. opa eval -f pretty --explain=notes  --data rds-validate.rego --input tfplan.json "authorized = data.terraform.analysis.authz; violations = data.terraform.analysis.violation"
```

## Resources

- [Policies](https://github.com/mjlshen/terraform-aws-opa)
- [Policies](https://github.com/ik-learning/sample-tf-opa-policies)
- [Tutorial](https://www.scalr.com/blog/opa-series-part-2-opa-logic-and-structure-for-scalr)

## Create

[**Create a repository using this template →**][template.generate]

<!-- resources -->
[template.generate]: https://github.com/ik-learning/opa-learn/generate
[code-style.badge]: https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square


Gitlab
- https://github.com/SecurityIsIllusion/opa-integration
- https://gitlab.com/memorandom/open-policy-agent-first-steps/-/tree/master/
- https://gitlab.com/nico-meisenzahl/demo-opa-terraform-validation/-/tree/main/
- Secrets/Gitlab https://gitlab.com/gitlab-com/gl-security/engineering-and-research/gib/-/tree/main/

OPA slideshare https://www.slideshare.net/nmeisenzahl/gitlab-commit-enhance-your-compliance-with-policybased-cicd

- https://spacelift.io/blog/what-is-open-policy-agent-and-how-it-works
- http://i-cloudconsulting.com/cloud-compliance-opa-policies/
- https://epam.github.io/edp-install/user-guide/opa-stages/
- https://academy.styra.com/collections?page=1
