# sdlc-skills

Reusable Claude Code skills that take a project from idea to production, in order:

```
requirements → architecture (PDF) → [client sign-off] → build → deploy
                                                          ├─ security  (after every deploy)
                                                          └─ qa        (load/stress/resilience)
feature — research → design → explore → implement, for any later change
```

| Skill | Command | Output |
|---|---|---|
| requirements | `/sdlc:requirements` | `docs/requirements/REQUIREMENTS.md` |
| architecture | `/sdlc:architecture` | `docs/architecture/ARCHITECTURE.md` + `.pdf` |
| build (gated on client approval) | `/sdlc:build` | web / mobile / api / infra / CI code |
| security | `/sdlc:security <env>` | `docs/security/<date>-<env>.md` |
| qa | `/sdlc:qa <env>` | `docs/qa/<date>-<env>.md` |
| feature | `/sdlc:feature <idea>` | `docs/features/<slug>.md` + code |

## Install in a project

**Option A - plugin (recommended; updates flow to every project):**
```
/plugin marketplace add om25091210/sdlc-skills
/plugin install sdlc@sdlc-skills
```

**Option B - copy into a repo (files live in that repo, commands are `/sdlc-requirements` etc.):**
```
./install.sh /path/to/new-repo
./install.sh https://github.com/you/new-repo.git my-branch   # clones, installs, leaves commit to you
```

Hard gates: `build` refuses to start without `docs/architecture/APPROVAL.md`; `qa` won't load-test
production without explicit confirmation.
