<?php
// Step 1: Set up database connection
$servername = "localhost";
$username = "root";
$password = "";
$database = "uintikilpailu";

$conn = mysqli_connect($servername, $username, $password, $database);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$competitionQuery = "SELECT * FROM kilpailu";
$competitionResult = mysqli_query($conn, $competitionQuery);

// Check if the form is submitted and get the selected competition name
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['competitionSelect'])) {
        $selectedCompetition = $_POST['competitionSelect'];

        $swimmerQuery = "SELECT uimari.etunimi, uimari.sukunimi FROM osallistuja
        RIGHT JOIN uimari ON osallistuja.uimariId = uimari.id
        INNER JOIN seura ON uimari.seuraId = seura.id
        INNER JOIN kilpailunlaji ON osallistuja.kilpailunlajiId = kilpailunlaji.id
        INNER JOIN laji ON kilpailunlaji.lajiId = laji.id
        INNER JOIN kilpailu ON kilpailunlaji.kilpailuId = kilpailu.id
        WHERE kilpailu.nimi = '$selectedCompetition'";
        $swimmerResult = mysqli_query($conn, $swimmerQuery);
    }
}
?>

<!DOCTYPE html>
<html>
<head>
  <title>Swimmer Competition page</title>
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }
    
    th, td {
      padding: 8px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    
    th:first-child, td:first-child {
      width: auto;
      white-space: nowrap;
    }
    
    th:not(:first-child), td:not(:first-child) {
      width: calc(100% / 6 + 5px);
    }
  </style>
</head>
<body>
  <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
    <label for="competitionSelect">Select Competition:</label>
    <select name="competitionSelect" id="competitionSelect">
      <?php
      // Loop through the competition results and create option elements
      while ($row = mysqli_fetch_assoc($competitionResult)) {
        $competitionName = $row['nimi'];
        $selected = ($selectedCompetition === $competitionName) ? 'selected' : '';
        echo "<option value='$competitionName' $selected>$competitionName</option>";
      }
      ?>
    </select>
    <button type="submit">Submit</button>
  </form>

  <?php if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['competitionSelect'])) { ?>
    <?php
    // Get the competition details
    $competitionDetailsQuery = "SELECT * FROM kilpailu WHERE nimi = '$selectedCompetition'";
    $competitionDetailsResult = mysqli_query($conn, $competitionDetailsQuery);
    $competitionDetails = mysqli_fetch_assoc($competitionDetailsResult);
    ?>

    <br>

    <table>
      <tr>
        <th>Competition</th>
        <th>Address</th>
        <th>Date</th>
        <th>Järjestäjä</th>
        <th>allas</th>
      </tr>
      <tr>
        <td><?php echo $competitionDetails['nimi']; ?></td>
        <td><?php echo $competitionDetails['osoite']; ?></td>
        <td><?php echo $competitionDetails['päivämäärä']; ?></td>
        <td><?php echo $competitionDetails['järjestäjä']; ?></td>
        <td><?php echo $competitionDetails['allas']; ?></td>


      </tr>
    </table>

    <br>

    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <label for="swimmerSelect">Select Swimmer:</label>
      <select name="swimmerSelect" id="swimmerSelect">
        <?php
        // Loop through the swimmer results and create option elements
        while ($swimmerRow = mysqli_fetch_assoc($swimmerResult)) {
          $swimmerFullName = $swimmerRow['etunimi'] . ' ' . $swimmerRow['sukunimi'];
          echo "<option value='$swimmerFullName'>$swimmerFullName</option>";
        }
        ?>
      </select>
      <input type="hidden" name="competitionSelect" value="<?php echo $selectedCompetition; ?>">
      <button type="submit" name="swimmerSubmit">Submit</button>
    </form>

    <br><br>

    <?php
    if (isset($_POST['swimmerSubmit'])) {
        $selectedSwimmer = $_POST['swimmerSelect'];
    
        $selectedSwimmerDataQuery = "SELECT uimari.etunimi, uimari.sukunimi, uimari.syntymäaika, kilpailu.nimi, seura.nimi AS seura, GROUP_CONCAT(CONCAT(laji.matka, ' ', laji.nimi) SEPARATOR ', ') AS events
        FROM osallistuja
        INNER JOIN uimari ON osallistuja.uimariId = uimari.id
        INNER JOIN seura ON uimari.seuraId = seura.id
        INNER JOIN kilpailunlaji ON osallistuja.kilpailunlajiId = kilpailunlaji.id
        INNER JOIN laji ON kilpailunlaji.lajiId = laji.id
        INNER JOIN kilpailu ON kilpailunlaji.kilpailuId = kilpailu.id
        WHERE CONCAT(uimari.etunimi, ' ', uimari.sukunimi) = '$selectedSwimmer' AND kilpailu.nimi = '$selectedCompetition' 
        GROUP BY uimari.etunimi, uimari.sukunimi, uimari.syntymäaika, seura.nimi";
        $selectedSwimmerDataResult = mysqli_query($conn, $selectedSwimmerDataQuery);
    
        if (mysqli_num_rows($selectedSwimmerDataResult) > 0) {
            $selectedSwimmerData = mysqli_fetch_assoc($selectedSwimmerDataResult);
        ?>

        <table>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>Competition</th>
            <th>Club</th>
            <th>Events</th>
          </tr>
          <tr>
            <td><?php echo $selectedSwimmerData['etunimi']; ?></td>
            <td><?php echo $selectedSwimmerData['sukunimi']; ?></td>
            <td><?php echo $selectedSwimmerData['syntymäaika']; ?></td>
            <td><?php echo $selectedSwimmerData['nimi']; ?></td>
            <td><?php echo $selectedSwimmerData['seura']; ?></td>
            <td><?php echo $selectedSwimmerData['events']; ?></td>
          </tr>
        </table>

        <?php
      } else {
        echo "No data found for the selected swimmer.";
      }
    }
    mysqli_close($conn);
    ?>
  <?php } ?>

</body>
</html>
