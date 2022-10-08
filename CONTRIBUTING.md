# Contributing

Dansdata is a project by dancers, for dancers. Contributions are welcome!

## Code Standard

All code should be formatted with `npm run format`.

If you are adding a new language to the repository, please extend the `npm run format`
command with an appropriate formatter. If possible, the `npm run format-check` command
should also be extended to verify the formatter has been applied. _Opinionated_ formatters
are preferred to ensure consistency.

## Git Standard

The Dansdata project strives for a readable git history. Branches are therefore merged
to `main` using the rebase strategy. This preserves each individual commit, making changes
to individual lines easier to follow and history entries smaller.

### Commits

Every commit should strive to do _one thing and one thing only_, whether that be reformat
code, remove unused imports or implementing new functionality. Please keep your commits as
small as possible and separate unrelated changes from each other.

Commits _should_ follow the following template:

```
gh-{issue-id}: Subject line

Why is this change needed?

How does this commit address the issue?

Additional information
```

The `gh-{issue-id}` prefix may be skipped if there is no associated issue id.

The subject line _should_ be shorter than 50 characters and _must_ be shorter than
80 characters.

The body lines _must_ be shorter than 80 characters. URLs/similar are exempt from this
rule, though such lines should be shortened as much as possible.

There are times when a single-line commit is warranted but it is preferred to err on the
side of verbosity.

## Pull Requests

To make review work easier, pull requests are requested to use [`fixup` commits](https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html) to
address comments.

If you need to update your commit messages, `squash` commits can be a good way to make such
intentions clear in a similar way to `fixup` commits.

### Example

#### 1. You push some work to a PR

```
abcd123 Feature A is done
1234abc Feature B is done
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
# fixup! Feature A is done
# ```
# to
# ```
# fixup! Feature A is done
#
# Change langage -> language
# ```
# This helps reviewers know which comment is addressed by the fixup
# (This part is optional - but helpful)
git commit --amend
````

#### 4. You push your fixup

```
abcd123 Feature A is done
1234abc Feature B is done
efgh123 fixup! Feature A is done
qwer123 fixup! Feature B is done
zxcv123 fixup! Feature A is done
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
abcd123 Feature A is done
efgh123 fixup! Feature A is done
ijkl123 fixup! Feature A is done
```

_not_ this:

```
abcd123 Feature A is done
efgh123 fixup! Feature A is done
ijkl123 fixup! fixup! Feature A is done
```