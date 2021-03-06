cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull:
      reanahub/reana-env-root6
  InitialWorkDirRequirement:
    listing:
      - $(inputs.gendata_tool)

inputs:
  gendata_tool: File
  events: int
  outfilename:
    type: string
    default: data.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -b -q '$(inputs.gendata_tool.basename)($(inputs.events),"$(runtime.outdir)/$(inputs.outfilename)")'

stdout: gendata.log

outputs:
  gendata.log:
    type: stdout
  data:
    type: File
    outputBinding:
      glob: $(inputs.outfilename)
