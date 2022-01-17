#To check file exist or not

if ((Test-Path 'C:\Test powershel\test.txt') -eq "true")
{
  echo fiel already exits 
}

else
 {
    echo not exist


 }