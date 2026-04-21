namespace com.vendortracker;

entity Vendors {
  key ID        : UUID;
  name          : String(100);
  email         : String(100);
  country       : String(50);
}

entity PurchaseOrders {
  key ID        : UUID;
  vendor        : Association to Vendors;
  itemDescription : String(200);
  amount        : Decimal(10,2);
  status        : String(20) default 'Pending';  // Pending/Approved/Paid
  createdAt     : DateTime;
}

entity Invoices {
  key ID        : UUID;
  purchaseOrder : Association to PurchaseOrders;
  invoiceNumber : String(50);
  amount        : Decimal(10,2);
  status        : String(20) default 'Submitted'; // Submitted/Verified/Rejected
  submittedAt   : DateTime;
}