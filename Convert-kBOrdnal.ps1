<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.150
	 Created by:   	Rich Stoddart
	 Filename:     Convert-kBOrdinal.ps1	
	===========================================================================
	.DESCRIPTION
		Functions to format output by standard Metric Prefixs for binary (1024) 
		and decimal (1000) units. 
		Created to format data concisely on reports, 
		this will process things to as large a number you cn old in a [decimal] 
		type. 
	.EXAMPLE
		gci |% { New-Object -TypeName PSObject -Property ( @{Length = ($_.Length | Convert-kBOrdinal) ; Name = $_.Name}})
		(gi .\install.exe ).length | Convert-kBOrdinal
#>

function Convert-kBOrdinal
{
	param (
		[Parameter(ValueFromPipeline, Position = 0, Mandatory = $true)]
		[decimal]$Num,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$digits = 2,
		[Parameter(Position = 2, Mandatory = $false)]
		[string]$Units = "B"
	)
	
	if ($NUM -lt 1E+28)
	{
		[int]$Ordinal = ([math]::Floor((($Num.ToString()).Length - 1)/ 3))
		[string]$Digit = [math]::Round($Num / [math]::pow(1024, $Ordinal), $digits)
		[string]$Suffix = "$(((' KMGTPEZYB').Substring($Ordinal, 1)).Trim())$Units"
	}
	Else { "OverRange" }
	return $Digit + $Suffix
}

function Convert-kOrdinal
{
	param (
		[Parameter(ValueFromPipeline, Position = 0, Mandatory = $true)]
		[decimal]$Num,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$digits = 2,
		[Parameter(Position = 2, Mandatory = $false)]
		[string]$Units
	)
	
	if ($NUM -lt 1E+28)
	{
		[int]$Ordinal = ([math]::Floor((($Num.ToString()).Length - 1)/ 3))
		[string]$Digit = [math]::Round($Num / [math]::pow(1000, $Ordinal), $digits)
		[string]$Suffix = "$(((' KMGTPEZYB').Substring($Ordinal, 1)).Trim())$Units"
	}
	Else { "OverRange" }
}
