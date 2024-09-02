; M6515.g - CHECK MACHINE LIMITS
;
; This macro checks if the given position is within the limits
; of the machine. It will trigger an abort if any of the positions
; are outside of the machine limits.
; Positions are given in userPosition, which is dependent on the
; current WCS. We calculate a machine position by adding the
; userPosition to the workplaceOffset.

; Make sure this file is not executed by the secondary motion system
if { !inputs[state.thisInput].active }
    M99

if { !exists(param.X) && !exists(param.Y) && !exists(param.Z) }
    abort { "M6515: Must provide at least one of X, Y and Z parameters!" }

; Check if target position is within machine limits on each axis.
if { exists(param.X) }
    var mpX = { param.X + move.axes[0].workplaceOffset[move.workplaceNumber] }
    if { (var.mpX < move.axes[0].min || var.mpX > move.axes[0].max) }
        abort { "Target probe position X=" ^ param.X ^ " is outside machine limit on X axis. Reduce overtravel if probing away, or clearance if probing towards, the center of the table" }

if { exists(param.Y) }
    var mpY = { param.Y + move.axes[1].workplaceOffset[move.workplaceNumber] }
    if { (var.mpY < move.axes[1].min || var.mpY > move.axes[1].max) }
        abort { "Target probe position Y=" ^ param.Y ^ " is outside machine limit on Y axis. Reduce overtravel if probing away, or clearance if probing towards, the center of the table" }

if { exists(param.Z) }
    var mpZ = { param.Z + move.axes[2].workplaceOffset[move.workplaceNumber] }
    if { (var.mpZ < move.axes[2].min || var.mpZ > move.axes[2].max) }
        abort { "Target probe position Z=" ^ param.Z ^ " is outside machine limit on Z axis." }