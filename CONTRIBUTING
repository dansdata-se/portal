# Contributing

Dansdata is a project by dancers, for dancers. Contributions are welcome!

## Code Standard

All code should be formatted with `npm run format`.

If you are adding a new language to the repository, please extend the `npm run format`
command as well as [`.lintstagedrc`](./.lintstagedrc) with an appropriate formatter.
_Opinionated_ formatters are preferred to ensure consistency.

## Git Standard

The Dansdata project strives for a readable git history. Branches are therefore merged
using the rebase strategy. This preserves each individual commit, making changes to individual
lines easier to follow and history entries smaller.

PRs should be created from/to the `develop` branch.

### Commits

Every commit should strive to do _one thing and one thing only_, whether that be reformat
code, remove unused imports or implementing new functionality. Please keep your commits as
small as possible and separate unrelated changes from each other.

Commit messages _must_ follow the [conventional](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional)
config and will be validated using [`commitlint`](https://commitlint.js.org/). See also
https://www.conventionalcommits.org/ .

When working on a specific issue, the issue id should be used as the scope, e.g.
`fix(API-123): something related to issue API-123`.

There are times when a single-line commit is warranted but it is preferred to err on the
side of verbosity. Please try to include the following information in your commits:

- Why this change was necessary
- What the change does
- Known issues with the solution
- Other relevant information

## Pull Requests

To make review work easier, pull requests are requested to use [`fixup` commits](https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html)
to address comments.

If you need to update your commit messages, `squash` commits can be a good way to make such
intentions clear in a similar way to `fixup` commits.

### Example

#### 1. You push some work to a PR

```
abcd123 feature(123): feature A is done
1234abc feature(123): feature B is done
```

#### 2. You receive some comments

```
Please correct this spelling error
---
Please remove this unused import
---
...
```

#### 3. You address the comments

Repeat for each comment - please use one fixup per comment to make reviews easier.

````bash
git commit --fixup abcd123

# Change message from
# ```
# fixup! feature(API-123): feature A is done
# ```
# to
# ```
# fixup! feature(API-123): feature A is done
#
# Change langage -> language
# ```
# This helps reviewers know which comment is addressed by the fixup
# (This part is optional - but helpful)
git commit --amend
````

#### 4. You push your fixup

```
abcd123 feature(API-123): feature A is done
1234abc feature(API-123): feature B is done
efgh123 fixup! feature(API-123): feature A is done
qwer123 fixup! feature(API-123): feature B is done
zxcv123 fixup! feature(API-123): feature A is done
```

#### The review continues...

Reviewed fixups may be integrated with the commit they are targeting using

```bash
git rebase -i (--autosquash)
```

All fixups must be integrated with their target commit before the PR branch is merged. You
will need to use `git push -f` to update your PR branch after performing this history
rewrite.

### Fixups for Fixups

When addressing issues raised for a fixup, your new fixups should still target the original
commit.

i.e. do this:

```
abcd123 feature(API-123): feature A is done
efgh123 fixup! feature(API-123): feature A is done
ijkl123 fixup! feature(API-123): feature A is done
```

_not_ this:

```
abcd123 feature(API-123): feature A is done
efgh123 fixup! feature(API-123): feature A is done
ijkl123 fixup! fixup! feature(API-123): feature A is done
```
