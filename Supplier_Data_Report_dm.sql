-- Chapter 16: BI Publisher Report. Data model Supplier_Data_Report_dm, data source ApplicationDB_FSCM, parameter P_VENDOR_ID.
-- Paste this query into the data model after unarchiving BIP-Report.catalog.
SELECT * FROM (
  SELECT a.po_header_id              "POHeaderId",
         b.po_line_id                "POLineId",
         c.promised_date             "PromisedDeliveryDate",
         b.quantity                  "OrderedQuantity",
         c.need_by_date              "NeedByDate",
         NVL(c.quantity_received, 0) "ReceivedQuantity"
  FROM   po_headers_all a,
         po_lines_all b,
         po_line_locations_all c
  WHERE  a.vendor_id    = :p_vendor_id
  AND    a.po_header_id = b.po_header_id
  AND    b.po_line_id   = c.po_line_id
  ORDER BY a.creation_date DESC
)
WHERE ROWNUM <= 25
