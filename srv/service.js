const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { Invoices, PurchaseOrders } = this.entities;

  // Auto-update PO status when invoice is approved
  this.on('approveInvoice', async (req) => {
    const { invoiceId } = req.data;
    await UPDATE(Invoices).set({ status: 'Verified' }).where({ ID: invoiceId });
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceId });
    await UPDATE(PurchaseOrders).set({ status: 'Paid' }).where({ ID: invoice.purchaseOrder_ID });
    return `Invoice ${invoiceId} approved and PO marked as Paid.`;
  });

  this.on('rejectInvoice', async (req) => {
    const { invoiceId } = req.data;
    await UPDATE(Invoices).set({ status: 'Rejected' }).where({ ID: invoiceId });
    return `Invoice ${invoiceId} has been rejected.`;
  });
});