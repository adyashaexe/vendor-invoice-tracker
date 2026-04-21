using com.vendortracker as db from '../db/schema';

service VendorService {
  entity Vendors        as projection on db.Vendors;
  entity PurchaseOrders as projection on db.PurchaseOrders;
  entity Invoices       as projection on db.Invoices;

  action approveInvoice(invoiceId: UUID) returns String;
  action rejectInvoice(invoiceId: UUID)  returns String;
}