# Code Walkthrough Video

## Video Link

[Watch the code walkthrough](https://drive.google.com/file/d/12PTDLR67TVvGyT-c6Na2IsTdVDFAR5-T/view?usp=sharing)

## Team Member Timestamps

| Team Member | Timestamp Range | Portion Explained |
|---|---|---|
| Siddhi Gulati | `00:00–07:57` | Kernel-side trace implementation, process tracing state, and inheritance during `fork()`. |
| Rudranshi Airen | `07:58–10:08` | Manual system-call interface chart and verification of the `SYS_trace`, `trace(int)`, syscall stub, and kernel-handler mapping. |
| Dhruv Garg | `10:10–13:11` | Test programs, build integration, program execution, and output verification. |

## Demonstration Coverage

The walkthrough includes:

- The system-call interface and `SYS_trace` number.
- The `trace(int)` user declaration and generated syscall stub.
- Kernel dispatch from `SYS_trace` to `sys_trace()`.
- Per-process tracing state and inheritance during `fork()`.
- Building xv6 and running `trace` and `tracefork`.
- An explanation from every team member in their own voice.