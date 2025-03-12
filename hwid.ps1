cls
function Get-HWID {
    try {
        # Sistem bilgilerini topla
        $computerName = $env:COMPUTERNAME
        $userName = $env:USERNAME
        $processorId = $env:PROCESSOR_IDENTIFIER
        $processorLevel = $env:PROCESSOR_LEVEL

        $toEncrypt = "$computerName$userName$processorId$processorLevel"

        $md5 = [System.Security.Cryptography.MD5]::Create()
        $inputBytes = [System.Text.Encoding]::UTF8.GetBytes($toEncrypt)
        $hashBytes = $md5.ComputeHash($inputBytes)

        $sb = [System.Text.StringBuilder]::new()
        foreach ($byte in $hashBytes) {
            [void]$sb.Append($byte.ToString("x2"))
        }

        return $sb.ToString()

    } catch {
        Write-Error $_.Exception.Message
        return "Error"
    }
}


$hwid = Get-HWID
Write-Output ""
Write-Output "SEND YOUR HWID TO STAFF FOR LINK UR LICENSE"
Write-Output ""
Write-Output "HWID: $hwid"
Write-Output ""
