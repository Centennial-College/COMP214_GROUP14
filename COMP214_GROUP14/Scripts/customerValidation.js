
function validateTxtCategory(oSrc, args) {
    args.IsValid = (args.Value.toString().trim() != "") && (args.Value.toString().trim().toLowerCase() != "other");
}
