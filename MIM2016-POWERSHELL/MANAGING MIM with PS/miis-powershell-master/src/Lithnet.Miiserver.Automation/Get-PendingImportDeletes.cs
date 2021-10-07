﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Management.Automation;
using Lithnet.Miiserver.Client;
using System.IO;

namespace Lithnet.Miiserver.Automation
{
    [Cmdlet(VerbsCommon.Get, "PendingImportDeletes")]
    public class GetPendingImportDeletes : MATargetCmdlet
    {
        [Parameter]
        public SwitchParameter Delta { get; set; }

        [Parameter]
        public SwitchParameter Hologram { get; set; }

        protected override void ProcessRecord()
        {
            foreach (var item in this.MAInstance.GetPendingImports(false, false, true))
            {
                if (this.Delta.IsPresent)
                {
                    this.WriteObject(item.PendingImportDelta);
                }
                else if (this.Hologram.IsPresent)
                {
                    this.WriteObject(item.PendingImportHologram);
                }
                else
                {
                    this.WriteObject(item);
                }
            }
        }
    }
}
