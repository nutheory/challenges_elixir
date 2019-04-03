defmodule FactorialDecompositionTest do
  use ExUnit.Case

  def testing(n, exp) do
    IO.puts("Testing : #{n}")
    act = FactorialDecomposition.decomp(n)
    IO.puts("act: #{act}")
    IO.puts("exp: #{exp}")
    assert act == exp
    IO.puts("#")
  end

  test "decomp" do
    testing(17, "2^15 * 3^6 * 5^3 * 7^2 * 11 * 13 * 17")
    testing(5, "2^3 * 3 * 5")
    testing(22, "2^19 * 3^9 * 5^4 * 7^3 * 11^2 * 13 * 17 * 19")
    testing(14, "2^11 * 3^5 * 5^2 * 7^2 * 11 * 13")
    testing(25, "2^22 * 3^10 * 5^6 * 7^3 * 11^2 * 13 * 17 * 19 * 23")

    testing(
      2167,
      "2^2160 * 3^1078 * 5^539 * 7^359 * 11^215 * 13^178 * 17^134 * 19^120 * 23^98 * 29^76 * 31^71 * 37^59 * 41^53 * 43^51 * 47^46 * 53^40 * 59^36 * 61^35 * 67^32 * 71^30 * 73^29 * 79^27 * 83^26 * 89^24 * 97^22 * 101^21 * 103^21 * 107^20 * 109^19 * 113^19 * 127^17 * 131^16 * 137^15 * 139^15 * 149^14 * 151^14 * 157^13 * 163^13 * 167^12 * 173^12 * 179^12 * 181^11 * 191^11 * 193^11 * 197^11 * 199^10 * 211^10 * 223^9 * 227^9 * 229^9 * 233^9 * 239^9 * 241^8 * 251^8 * 257^8 * 263^8 * 269^8 * 271^7 * 277^7 * 281^7 * 283^7 * 293^7 * 307^7 * 311^6 * 313^6 * 317^6 * 331^6 * 337^6 * 347^6 * 349^6 * 353^6 * 359^6 * 367^5 * 373^5 * 379^5 * 383^5 * 389^5 * 397^5 * 401^5 * 409^5 * 419^5 * 421^5 * 431^5 * 433^5 * 439^4 * 443^4 * 449^4 * 457^4 * 461^4 * 463^4 * 467^4 * 479^4 * 487^4 * 491^4 * 499^4 * 503^4 * 509^4 * 521^4 * 523^4 * 541^4 * 547^3 * 557^3 * 563^3 * 569^3 * 571^3 * 577^3 * 587^3 * 593^3 * 599^3 * 601^3 * 607^3 * 613^3 * 617^3 * 619^3 * 631^3 * 641^3 * 643^3 * 647^3 * 653^3 * 659^3 * 661^3 * 673^3 * 677^3 * 683^3 * 691^3 * 701^3 * 709^3 * 719^3 * 727^2 * 733^2 * 739^2 * 743^2 * 751^2 * 757^2 * 761^2 * 769^2 * 773^2 * 787^2 * 797^2 * 809^2 * 811^2 * 821^2 * 823^2 * 827^2 * 829^2 * 839^2 * 853^2 * 857^2 * 859^2 * 863^2 * 877^2 * 881^2 * 883^2 * 887^2 * 907^2 * 911^2 * 919^2 * 929^2 * 937^2 * 941^2 * 947^2 * 953^2 * 967^2 * 971^2 * 977^2 * 983^2 * 991^2 * 997^2 * 1009^2 * 1013^2 * 1019^2 * 1021^2 * 1031^2 * 1033^2 * 1039^2 * 1049^2 * 1051^2 * 1061^2 * 1063^2 * 1069^2 * 1087 * 1091 * 1093 * 1097 * 1103 * 1109 * 1117 * 1123 * 1129 * 1151 * 1153 * 1163 * 1171 * 1181 * 1187 * 1193 * 1201 * 1213 * 1217 * 1223 * 1229 * 1231 * 1237 * 1249 * 1259 * 1277 * 1279 * 1283 * 1289 * 1291 * 1297 * 1301 * 1303 * 1307 * 1319 * 1321 * 1327 * 1361 * 1367 * 1373 * 1381 * 1399 * 1409 * 1423 * 1427 * 1429 * 1433 * 1439 * 1447 * 1451 * 1453 * 1459 * 1471 * 1481 * 1483 * 1487 * 1489 * 1493 * 1499 * 1511 * 1523 * 1531 * 1543 * 1549 * 1553 * 1559 * 1567 * 1571 * 1579 * 1583 * 1597 * 1601 * 1607 * 1609 * 1613 * 1619 * 1621 * 1627 * 1637 * 1657 * 1663 * 1667 * 1669 * 1693 * 1697 * 1699 * 1709 * 1721 * 1723 * 1733 * 1741 * 1747 * 1753 * 1759 * 1777 * 1783 * 1787 * 1789 * 1801 * 1811 * 1823 * 1831 * 1847 * 1861 * 1867 * 1871 * 1873 * 1877 * 1879 * 1889 * 1901 * 1907 * 1913 * 1931 * 1933 * 1949 * 1951 * 1973 * 1979 * 1987 * 1993 * 1997 * 1999 * 2003 * 2011 * 2017 * 2027 * 2029 * 2039 * 2053 * 2063 * 2069 * 2081 * 2083 * 2087 * 2089 * 2099 * 2111 * 2113 * 2129 * 2131 * 2137 * 2141 * 2143 * 2153 * 2161"
    )
  end
end