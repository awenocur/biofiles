// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// gbFeature
SEXP gbFeature(std::vector<std::string> feature, Rcpp::S4 seqinfo, std::string accession = "", int id = 0);
RcppExport SEXP biofiles_gbFeature(SEXP featureSEXP, SEXP seqinfoSEXP, SEXP accessionSEXP, SEXP idSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        std::vector<std::string> feature = Rcpp::as<std::vector<std::string> >(featureSEXP);
        Rcpp::S4 seqinfo = Rcpp::as<Rcpp::S4 >(seqinfoSEXP);
        std::string accession = Rcpp::as<std::string >(accessionSEXP);
        int id = Rcpp::as<int >(idSEXP);
        SEXP __result = gbFeature(feature, seqinfo, accession, id);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
// gbLocation
SEXP gbLocation(std::string gb_base_span, std::string accession = "");
RcppExport SEXP biofiles_gbLocation(SEXP gb_base_spanSEXP, SEXP accessionSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        std::string gb_base_span = Rcpp::as<std::string >(gb_base_spanSEXP);
        std::string accession = Rcpp::as<std::string >(accessionSEXP);
        SEXP __result = gbLocation(gb_base_span, accession);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
