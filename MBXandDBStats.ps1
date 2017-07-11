
[CmdletBinding()]
Param(

   [Parameter(Mandatory=$True)]
   [string]$filePath
)

# Generate a list with number of databases on each Exchange Server
Write-Host Getting count of databases on each server... -ForegroundColor "Cyan" 

    # Create a HashTable to store database count
    $DBCount = @{}

    #Get list of Exchange Servers
    $Servers = (Get-ExchangeServer).name


        ForEach ($Server in $Servers)
            {
            # Get-MaiboxDatabase on each server
            $DBs = Get-MailboxDatabase -Server $server | sort name

            # Add databases into the HashTable
            $DBCount.Add($Server,$DBs.Count)

            # Keep a running output so you see the work being done.
            Write-Host $server $DBs.Count
             }
    Write-Host $nl

    # Output the results to a text file named DatabasesPerServer.txt
    $DBCount | sort server  > $filePath\DatabasesPerServer.txt


# Generate a list with number of mailboxes per database
Write-Host Getting count of mailboxes on each database... -ForegroundColor "Cyan"

    # Create a HashTable to store mailbox count
    $MBXCount = @{}

    # Get list of Mailbox Databases
    $Databases = (Get-MailboxDatabase).name

        ForEach ($Database in $Databases)
            {
            # Get-Maibox on each database
            $MBXs = Get-Mailbox -Database $Database | sort name

            # Add mailboxes into the HashTable
            $MBXCount.Add($Database,$MBXs.Count)

            # Keep a running output so you see the work being done.
            Write-Host $Database $MBXs.Count
             }

 Write-Host $nl

     # Output results to a text file named MailboxesPerDatabase.txt
     $MBXCount | sort server > $filePath\MailboxesPerDatabase.txt

Write-Host $nl 
Write-Host Output files are located in $filePath -ForegroundColor "Cyan"
 
 


