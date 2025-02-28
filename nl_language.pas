unit nl_language;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


Resourcestring
  //Error messages
  rsError0001 = 'Error: Creating new wallet file-> %s';
  rsError0002 = 'Error: Loading wallet from file-> %s';
  rsError0003 = 'Error';
  rsError0004 = 'Error: Saving wallet to disk-> %s';
  rsError0005 = 'Error: Disconnecting client-> %s';
  rsError0006 = 'Error: Connecting node %s-> %s';
  rsError0007 = 'Error: Address already exists in wallet-> %s';
  rsError0008 = 'Error: Downloading summary from -> %s';
  rsError0009 = 'Error: Cannot delete - only one address in wallet';
  rsError0010 = 'Error: Invalid parameters for sending coins';
  rsError0011 = 'Error: Invalid password for address %s';
  rsError0012 = 'Error: Insufficient funds';
  rsError0013 = 'Error: Cannot generate certificates from locked addresses';
  rsError0014 = 'Error: Retrieving pending -> %s';
  rsError0015 = 'Error: Sending order -> %s';

  // GUI interface
  rsGUI0001 = 'Address';
  rsGUI0002 = 'Label';
  rsGUI0003 = 'Pending';
  rsGUI0004 = 'Balance';
  rsGUI0005 = 'Host';
  rsGUI0006 = 'Block';
  rsGUI0007 = 'Pending';
  rsGUI0008 = 'Branch';
  rsGUI0009 = '%s NOSO';
  rsGUI0010 = 'Import from file';
  rsGUI0011 = '[%s] %s';
  rsGUI0012 = 'Added new wallet: %s';
  rsGUI0013 = 'Summary downloaded: %d kb';
  rsGUI0014 = 'Destination';
  rsGUI0015 = 'Amount';
  rsGUI0016 = 'Reference';
  rsGUI0017 = 'Downloading summary %s';
  rsGUI0018 = 'Masternodes';
  rsGUI0019 = 'Peers';
  rsGUI0020 = 'Certificate for address: %s';
  rsGUI0021 = 'Processing...';
  rsGUI0022 = 'Send %s NOSO to %s'+slinebreak+'Reference: %s';
  rsGUI0023 = 'Failed';
  rsGUI0024 = 'Successful: %s';
  rsGUI0025 = 'Noso circulating supply is %s millions';
  rsGUI0026 = 'Check certificate';
  rsGUI0027 = '%s verified %s ago';
  rsGUI0028 = 'Invalid certificate';
  rsGUI0029 = 'BH';
  rsGUI0030 = 'Order Failed Error: %s';
  rsGUI0031 = 'Customize: %s';
  rsGUI0032 = 'Invalid custom alias';
  rsGUI0033 = 'Alias can not be a valid hash address';
  rsGUI0034 = 'Unknown';
  rsGUI0035 = '#';
  rsGUI0036 = 'Address';
  rsGUI0037 = 'Address already have a custom alias';
  rsGUI0038 = 'Noso';
  rsGUI0039 = 'nUSDo';
  rsGUI0040 = 'LiqShares';
  rsGUI0041 = 'Account';
  rsGUI0042 = 'Pool';
  rsGUI0043 = 'Price';
  rsGUI0044 = '   24 H Volume: %s nUSDo';
  rsGUI0045 = 'Time';
  rsGUI0046 = 'Amount';
  rsGUI0047 = 'Price';
  rsGUI0048 = '   Marketcap : %s US$';
  rsGUI0049 = 'LTC: %s US$';
  rsGUI0050 = 'Connecting...';
  // Dialogs
  rsDIA0001 = 'Import address keys';
  rsDIA0002 = 'Paste the address keys here';
  rsDIA0003 = 'Error: Invalid keys';
  rsDIA0004 = 'Password length must be 8 chars or more';
  rsDIA0005 = 'Passwords do not match';

  // Explorer
  rsEXP0001 = 'Name';

implementation

END. // End unit
