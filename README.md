# devour_fusion

**One capability bit from GBT V8, packaged standalone.** No. 78 of 341,
`devour` domain (Devour).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 吞天 × 原生能力 融合台账（主人令「把蒸馏提炼出契合自己的原生能力和吞天融合到一起…以及记入能力」）：吞进来的东西**三件齐才算融合** —— ①原生位三处齐（注册/分派/图鉴）②有效触手标签 ③触手库永久记忆页；`status=已融合` 而三件不齐**当场拒**（假账拦下）。`fuse` 补第三件（调 obsidian_vault.remember）；`audit` 逐条列缺件与补法。图片里那三个开源件先记 **`待吞`**（要装上才能吞，装不上就写不上）。op=intake/list/audit/fuse/verify/where

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-devour-fusion.git
cd gbt-devour-fusion
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_devour_fusion info                  # capability card
python -m gbt_devour_fusion spec --json           # machine-readable contract
python -m gbt_devour_fusion check --payload '{}'
python -m gbt_devour_fusion run   --payload '{}'
```

Real `info` output from this machine:

```text
devour_fusion  (devour)  v1.0.0
----------------------------------------
吞天 × 原生能力 融合台账（主人令「把蒸馏提炼出契合自己的原生能力和吞天融合到一起…以及记入能力」）：吞进来的东西**三件齐才算融合** —— ①原生位三处齐（注册/分派/图鉴）②有效触手标签 ③触手库永久记忆页；`status=已融合` 而三件不齐**当场拒**（假账拦下）。`fuse` 补第三件（调 obsidian_vault.remember）；`audit` 逐条列缺件与补法。图片里那三个开源件先记 **`待吞`**（要装上才能吞，装不上就写不上）。op=intake/list/audit/fuse/verify/where

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : intake, list, audit, fuse, verify, where
```

Wire a real implementation:

```python
from gbt_devour_fusion import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（6 个）**：`intake`、`list`、`audit`、`fuse`、`verify`、`where`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.12s
```

## Provenance

| field | value |
|---|---|
| capability | `devour_fusion` |
| domain | `devour` |
| handler | `devour_fusion` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [devour/devour_fusion](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/devour/devour_fusion.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
