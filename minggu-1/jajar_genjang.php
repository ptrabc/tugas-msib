<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Membuat Rumus Jarjar Genjang</title>
</head>
<body>
    <h1> Bangun Jajar Genjang </h1>

    <form method="POST">
        <table>
        <tr>
            <td>Alas</td>
            <td>
                <input type="text" name="alas" require>
            </td>
        </tr>
        <tr>
            <td>Tinggi</td>
            <td>
                <input type="text" name="tinggi" require>
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit" name="submit" value="Hitung">
        </td>
        </tr>
</table>
</form>
<?php 
    if(isset($_POST['submit'])){
        $alas = $_POST['alas'];
        $tinggi = $_POST['tinggi'];

        $jajargenjang = $alas * $tinggi;
        echo 'Hasil perhitungan Luas Persegi';
        echo '<br> Diketahui :';
        echo '<br> Alas : '.$alas;
        echo '<br> Tinggi : '.$tinggi;

        echo '<br> Maka Luasnya ' .$jajargenjang;
    }
?>
</body>
</html>