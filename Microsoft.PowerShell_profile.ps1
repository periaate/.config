# PowerShell configs

# Aliases, Variables, Etc
$go = "$home/go/src/"
$nvimconfig = "$home\AppData\Local\nvim\init.vim"
$mpvnetconfig = "$home\scoop\persist\mpvnet\portable_config\mpvnet.conf"
# $fancyzonesconfig
# $runconfig
$wtconfig = "$home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

New-Alias -Name e explorer
$m = "$home/go/src/setdb/main.go"

# Functions
function touch {
    <#
    .Description
    touch is an alias to replicate GNU/Linux functionality of the same name
    copied directly from some stack-overflow answer👍
    #>
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        (Get-Item -Path $Path).LastWriteTime = Get-Date
    } else {
        New-Item -Type File -Path $Path
    }
}

function barc {
    <#
    .Description
    barc runs build.sh; a basic gcc build and run script of main.c in current folder, or something
    #>
    wsl -d arch build.sh
}

function fp {
    <#
    .Description
    fp takes a path of a file and returns the path to the directory it's in
    #>
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string]$Path
    )
    Split-Path -Path $Path
}

function ~ {$home}

function lx([Parameter(ValueFromRemainingArguments)][string]$Text) {
    <#
    .Description
    lx is a function for running powershell commands with wsl commands.
    "!p" is replaced to powershell commands, which can be piped into other pwsh commands
    or into wsl commands.
    #>
    $Text = $Text.replace("!p", "powershell.exe -noprofile")
    $Text = $Text.replace("!to", "|")
    wsl /bin/bash -c $Text
}


# PSReadLine configuration
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Posh Git configuration
Import-Module posh-git
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptWriteStatusFirst = $true
