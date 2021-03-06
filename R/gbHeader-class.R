#### Layout of the entry fields in a GenBank Record ####
#
# LOCUS - Name for the entry. Mandatory keyword.
# 
# DEFINITION - A concise description of the sequence. Mandatory keyword.
# 
# ACCESSION  - The primary accession number. Mandatory keyword.
# 
# VERSION - The primary accession number and a numeric version number,
# followed by an integer key (GI) assigned to the sequence. Mandatory keyword.
# 
# DBLINK - Cross-references to resources that support the existence a sequence
# record (Project Database, NCBI Trace Assembly Archive). Optional keyword.
#
# DBSOURCE - GenPept only.
# 
# KEYWORDS - Other information about an entry. Mandatory keyword.
# 
# SEGMENT	- The order in which this entry appears in a series of discontinuous
# sequences from the same molecule. Optional keyword.
# 
# SOURCE	- Common name of the organism or the name most frequently used
# in the literature. Mandatory keyword. One Subkeyword.
#
#   ORGANISM - Formal scientific name of the organism.
#            - Taxonomic classification levels.
#
# REFERENCE - See below
#
# COMMENT  - Cross-references to other sequence entries, comparisons to
# other collections, notes of changes in LOCUS names, and other remarks.
# Optional keyword.
# 
# FEATURES - Feature Table. Optional keyword.
# 
# CONTIG - Information about how individual sequence records can be combined to
# form larger-scale biological objects, such as chromosomes or complete genomes.
# A special join() statement on the CONTIG line provides the accession numbers
# and basepair ranges of the underlying records which comprise the object.
#
# ORIGIN - Start of sequence data. Mandatory keyword.
# 
# // 	- Entry termination. Mandatory at the end of an entry.
#


#### Layout of a LOCUS record ####
#
#
# Keyword LOCUS, locus name (1) sequence length (2), bp or aa (3),
# if 'bp' molecule type (4), topology (5, optional), GenBank division (6),
# and modification date (7)
#
# Legal values for the division code include:
#   
# PRI - primate sequences
# ROD - rodent sequences
# MAM - other mammalian sequences
# VRT - other vertebrate sequences
# INV - invertebrate sequences
# PLN - plant, fungal, and algal sequences
# BCT - bacterial sequences
# VRL - viral sequences
# PHG - bacteriophage sequences
# SYN - synthetic sequences
# UNA - unannotated sequences
# EST - EST sequences (Expressed Sequence Tags) 
# PAT - patent sequences
# STS - STS sequences (Sequence Tagged Sites) 
# GSS - GSS sequences (Genome Survey Sequences) 
# HTG - HTGS sequences (High Throughput Genomic sequences) 
# HTC - HTC sequences (High Throughput cDNA sequences) 
# ENV - Environmental sampling sequences
# CON - Constructed sequences
# TSA - Transcriptome Shotgun Assembly sequences
#
#' Generator object for the \code{"gbLocus"} reference class
#'
#' @param ... List of arguments (see NOTE)
#' @section Methods:
#' \describe{
#'  \item{\code{#new(lnm, len, mtp, div, top, mdt, cdt)}:}{
#'    Create a new \code{\linkS4class{gbLocus}} object}
#'  \item{\code{#to_string()}:}{
#'    Create a string representation of a GenBank LOCUS field. }
#' }
#' 
#' @note Arguments to the \code{#new} method must be named arguments:
#' \itemize{
#' \item{lnm}{ Locus name; stored in the \code{lnm} field. }
#' \item{len}{ Sequence lenght; stored in the \code{len} field. }
#' \item{mtp}{ Molecule type; stored in the \code{mtp} field). }
#' \item{div}{ Genbank division; stored in the \code{div} field. }
#' \item{top}{ Topology; stored in the \code{top} field. }
#' \item{mdt}{ Modification date; stored in the \code{mdt} field. }
#' \item{cdt}{ Create date; stored in the \code{cdt} field. }
#' } 
#'
#' @keywords classes internal
.gbLocus <- setRefClass(
  'gbLocus',
  fields = list(
    lnm = 'character',
    len = 'integer',
    mtp = 'character',
    top = 'character',
    div = 'character',
    cdt = 'POSIXlt',
    mdt = 'POSIXlt'
  ),
  methods = list(
    initialize = function(lnm, len, mtp, top, div, cdt, mdt) {
      if (!nargs()) return()
      lnm <<- lnm
      len <<- as.integer(len)
      mtp <<- mtp
      top <<- top
      div <<- div
      cdt <<- with_c_locale(as.POSIXlt(cdt, format = "%d-%b-%Y")) 
      mdt <<- with_c_locale(as.POSIXlt(mdt, format = "%d-%b-%Y"))
    },
    is_empty = function() {
      sum(length(lnm), length(len), length(mtp), length(top),
          length(div), length(cdt), length(mdt)) != 7
    },
    to_string = function() {
      type <- if (mtp == "AA") "aa" else "bp"
      smtp <- ifelse(substring(mtp, 3, 3) == '-', mtp, paste0(blanks(3), mtp %|AA|% blanks(2)))
      sprintf("%-12s%-17s %+10s %s %-10s %-8s %s %s",
              "LOCUS", lnm, len, type, smtp, top %|na|% '', div,
              toupper(with_c_locale(format(mdt, "%d-%b-%Y"))))
    },
    show = function() {
      if (is_empty()) {
        showme <- sprintf("An empty %s instance.", sQuote(class(.self)))
      } else {
        showme <- paste0(
          sprintf("A %s instance:\n", sQuote(class(.self))),
          ellipsize(to_string())
          )
      }
      cat(showme, "\n", sep = "")
    }
  )
)

#' Generates an object representing a GenBank LOCUS line.
#' @name gbLocus-class
#' @section Fields:
#' \describe{
#'  \item{\code{lnm}:}{ Locus name. Usually the accession number. }
#'  \item{\code{len}:}{ Sequence length; In bp or aa, depending on \code{mtp}. }
#'  \item{\code{mtp}:}{ Molecule type; \emph{NA}, \emph{DNA}, \emph{RNA},
#'      \emph{tRNA} (transfer RNA), \emph{rRNA} (ribosomal RNA), \emph{mRNA}
#'      (messenger RNA), \emph{uRNA} (small nuclear RNA), or \emph{AA}
#'      (protein sequence). RNAs can be prefixes ss- (single-stranded),
#'      ds- (double-stranded), or ms- (mixed-stranded)}
#' \item{\code{div}:}{ Genbank division. }
#' \item{\code{top}:}{ Topology; linear, circular, or missing (\code{NA}). }
#' \item{\code{mdt}:}{ Modification date. }
#' \item{\code{cdt}:}{ Create date. }
#' }
#' @section Extends: All reference classes extend and inherit methods from
#'    \code{"\linkS4class{envRefClass}"}.
#' @keywords classes internal
#' @examples
#' showClass("gbLocus")
NULL

#### Layout of GenBank REFERENCE fields ####
#
# REFERENCE - Citations for all articles containing the data reported
# in this entry. Mandatory keyword. Six subkeywords. 
# 
#   AUTHORS  - Authors of the citation. Mandatory subkeyword (or CONSRTM).
# 
#   CONSRTM  - The collective names of consortia. Optional subkeyword.
# 
#   TITLE  - Full title of citation. Optional subkeyword.
# 
#   JOURNAL	- The journal name, volume, year, and page numbers of the citation.
#   Mandatory subkeyword.
# 
#   PUBMED - The PubMed unique identifier for a citation. Optional subkeyword.
# 
#   REMARK	- The relevance of a citation. Optional subkeyword.
#
#' Generator object for the \code{"gbReference"} reference class
#'
#' @param ... List of arguments.
#' @section Methods:
#' \describe{
#' \item{\code{#new(refline, authors, consrtm, title, journal, pubmed, remark)}:}{
#'    Create a new \code{\linkS4class{gbReference}} object}
#' \item{\code{#to_string(write_to_file = FALSE)}:}{
#'    Create a string representation of for GenBank article citations. }
#' }
#' 
#' @keywords classes internal
.gbReference <- setRefClass(
  'gbReference',
  fields = list(
    refline = 'character',
    authors = 'character',
    consrtm = 'character',
    title   = 'character',
    journal = 'character',
    pubmed  = 'character',
    remark  = 'character' 
  ),
  methods = list(
    has_authors = function() {
      length(authors) > 0L && !all(is.na(authors))
    },
    has_consrtm = function() {
      length(consrtm) > 0L && !all(is.na(consrtm))
    },
    is_empty = function() {
      (!has_authors() && !has_consrtm()) || length(journal) == 0L || all(is.na(journal))
    },
    to_string = function(write_to_file = FALSE) {
      'Generate a character string representation of a GenBank reference'
      if (write_to_file) {
        w <- 79
        f <- FALSE
      } else {
        w <- getOption("width") - 4
        f <- TRUE
      }
      o <- 12
      i <- -o
      paste0(
        sprintf('%-12s%s\n', 'REFERENCE', refline),
        if (has_authors()) {
          if (length(authors) > 1) {
            auth <- paste0(
              paste0(authors[-length(authors)], collapse = ", "), ' and ', authors[length(authors)]
            )
          } else {
            auth <- authors
          }
          sprintf('  %-10s%s\n', 'AUTHORS', linebreak(auth, width = w, indent = i, offset = o, FORCE = f))
        } else '',
        if (has_consrtm()) {
          sprintf('  %-10s%s\n', 'CONSRTM', linebreak(consrtm, width = w, indent = i, offset = o, FORCE = f))
        } else '',
        if (!is.na(title)) {
          sprintf('  %-10s%s\n', 'TITLE', linebreak(title, width = w, indent = i, offset = o, FORCE = f))
        } else '',
        sprintf('  %-10s%s\n', 'JOURNAL', linebreak(journal, width = w, indent = i, offset = o, FORCE = f)),
        if (!all(is.na(pubmed))) {
          sprintf('  %-10s%s\n', 'PUBMED', paste0(pubmed, collapse = "; "))
        } else '',
        if (!is.na(remark)) {
          sprintf('  %-10s%s\n', 'REMARK', linebreak(remark, width = w, indent = i, offset = o, FORCE = f))
        } else ''
      )
    },
    show = function() {
      'Method for automatically printing a Genbank file reference.'
      if (is_empty()) {
        showme <- sprintf("An empty %s instance.", sQuote(class(.self)))
      } else {
        showme <- paste0(
          sprintf("A %s instance:\n", sQuote(class(.self))),
          to_string(write_to_file = FALSE)
        )
      }
      cat(showme, "\n", sep = "")
    }
  )
)

#' Generates an  object representing a GenBank REFERENCE field. 
#' @name gbReference-class
#' @section Fields:
#' \describe{
#' \item{\code{refline}:}{ Top line of a reference entry.}
#' \item{\code{authors}:}{ Authors of the citation. Mandatory or \code{consrtm}. }
#' \item{\code{consrtm}:}{ The collective names of consortiums. Optional.}
#' \item{\code{title}:}{ Full title of citation. Optional. }
#' \item{\code{journal}:}{ The journal name, volume, year, and page numbers of
#'      the citation. Mandatory. }
#' \item{\code{pubmed}:}{ The PubMed unique identifier for a citation. Optional. }
#' \item{\code{remark}:}{ The relevance of a citation. Optional. }
#' }
#' @section Extends: All reference classes extend and inherit methods from
#'    \code{"\linkS4class{envRefClass}"}.
#' @keywords classes internal
#' @examples
#' showClass("gbReference")
NULL


set_reference <- function() {
  ref <- .gbReference()
  list(
    refline = function(refline) {
      if (is.empty(refline)) {
        stop("field 'REFERENCE' missing")
      }
      ref$refline <- refline
    },
    authors = function(authors) {
      ref$authors <- usplit(authors, ', | and ') %||% NA_character_
    },
    consrtm = function(consrtm) {
      ref$consrtm <- consrtm %||% NA_character_
    },
    title = function(title) {
      ref$title <- title %||% NA_character_
    },
    journal = function(journal) {
      if (is.empty(journal)) {
        stop("manadatory field 'JOURNAL' missing")
      }
      ref$journal <- journal
    },
    pubmed = function(pubmed) {
      ref$pubmed <- pubmed %||% NA_character_
    },
    remark = function(remark) {
      ref$remark <- remark %||% NA_character_
    },
    yield = function() {
      return(ref)
    }
  )
}

#' Generator object for the \code{"gbReferenceList"} reference class
#'
#' @param ... List of arguments
#' @section Methods:
#' \describe{
#' \item{\code{#new(ref)}:}{
#'    Create a new \code{\linkS4class{gbReferenceList}} object }
#' \item{\code{#to_string(write_to_file = FALSE)}:}{
#'    Create a string representation of a GenBank REFERENCE list. }
#' }
#'
#' @keywords classes internal
.gbReferenceList <- setRefClass(
  'gbReferenceList',
  fields = list('ref' = 'list'),
  methods = list(
    is_empty = function() {
      length(ref) == 0L
    },
    to_string = function(write_to_file = FALSE) {
      'Generate a character string representation of a GenBank reference list'
      paste0(
        vapply(ref, function(r) r$to_string(write_to_file = write_to_file), ""),
        collapse = ""
      ) 
    },
    show = function() {
      'Method for automatically printing Genbank file references.'
      if (is_empty()) {
        showme <- sprintf("An empty %s instance.", sQuote(class(.self)))
      } else {
        showme <- paste0(
          sprintf("A %s instance:\n", sQuote(class(.self))),
          to_string(write_to_file = FALSE)
        )
      }
      cat(showme, "\n", sep = "")
    }
  )
)

#' Generates an object representing a set of GenBank REFERENCE fields. 
#' @name gbReferenceList-class
#' @section Fields:
#' \describe{
#' \item{\code{ref}:}{ A list of \code{"\linkS4class{gbReference}"} objects. }
#' }
#' @section Extends: All reference classes extend and inherit methods from
#'    \code{"\linkS4class{envRefClass}"}.
#' @keywords classes internal
#' @examples
#' showClass("gbReferenceList")
NULL

#' Generator object for the \code{"gbHeader"} reference class
#'
#' @param ... List of arguments; must be named arguments
#' corresponding to the fields of a \code{\linkS4class{gbHeader}} object
#' @section Methods:
#' \describe{
#' \item{\code{#new(...)}:}{
#'    Create a new \code{\linkS4class{gbHeader}} object. }
#' \item{\code{#to_string(write_to_file = FALSE)}:}{
#'    Generate a character string representation of a GenBank file header. }
#' \item{\code{#write(file = "", append = FALSE, sep = "\n"}:}{
#'    Write a GenBank header to file. }
#' }
#' 
#' @keywords classes internal
.gbHeader <- setRefClass(
  'gbHeader',
  fields = list(
    locus = 'gbLocus',
    definition = 'character',
    accession = 'character',
    version = 'character',
    seqid = 'character', ## NCBI GI identifier
    dblink = 'character',
    dbsource = 'character', ## GenPept only
    keywords = 'character',
    source = 'character',
    organism = 'character',
    taxonomy = 'character',
    references = 'gbReferenceList',
    comment = 'character'
  ),
  methods = list(
    is_empty = function() {
      locus$is_empty() && sum(length(definition), length(accession)) != 2
    },
    to_string = function(write_to_file = FALSE) {
      'Generate a character string representation of a GenBank file header'
      if (write_to_file) {
        loc <- locus$to_string()
        w <- 79
        f <- FALSE
      } else {
        loc <- ellipsize(locus$to_string())
        w <- getOption("width") - 4
        f <- TRUE
      }
      o <- 12
      i <- -o
      paste0(
        loc,
        sprintf("\n%-12s%s\n", "DEFINITION", linebreak(definition, width = w, indent = i, offset = o, FORCE = f)),
        sprintf("%-12s%s\n", "ACCESSION", collapse(accession, "; ")),
        sprintf("%-12s%-12s%s%s\n", "VERSION", version, "GI:", strsplitN(seqid, "|", 2, fixed = TRUE)),
        if (!all(is.na(dblink))) {
          sprintf("%-12s%s%s\n", "DBLINK", "Project: ", dblink)
        } else '',
        sprintf("%-12s%s\n", "KEYWORDS", linebreak(keywords, width = w, indent = i, offset = o, FORCE = f)),
        sprintf("%-12s%s\n", "SOURCE", linebreak(source, width = w, indent = i, offset = o, FORCE = f)),
        sprintf("%-12s%s\n", "  ORGANISM",
                paste0(organism, '\n', dup(' ', 12), linebreak(taxonomy, width = w, indent = i, offset = o, FORCE = f))),
        references$to_string(write_to_file = write_to_file),
        if (!is.na(comment)) {
          sprintf("%-12s%s\n", "COMMENT", linebreak(comment, width = w, indent = i, offset = o, FORCE = f))
        } else '')
    },
    show = function() {
      'Method for automatically printing a Genbank file header.'
      if (is_empty()) {
        showme <- sprintf("An empty %s instance.", sQuote(class(.self)))
      } else {
        showme <- paste0(
          sprintf("A %s instance:\n", sQuote(class(.self))),
          to_string(write_to_file = FALSE)
        )
      }
      cat(showme, "\n", sep = "")
    },
    write = function(file = "", append = FALSE, sep = "\n") {
      'Write a GenBank file header to file.'
      cat(to_string(write_to_file = TRUE), file = file, append = append, sep = sep)
    }
  )
)

#' Generates an object representing a GenBank/GenPept-format file header. 
#' @name gbHeader-class
#' @section Fields:
#' \describe{
#' \item{\code{locus}:}{ A \code{"\linkS4class{gbLocus}"} object. }
#' \item{\code{definition}:}{ \code{character}; Description of the sequence. }
#' \item{\code{accession}:}{ \code{character}; The primary accession number.
#'      A unique, unchanging identifier assigned to each GenBank sequence record. }
#' \item{\code{version}:}{ \code{character}; The primary accession number and a
#'      numeric version number }
#' \item{\code{seqid}:}{ \code{character}; Gene Identifier ("GI"); An integer key
#'      assigned to the sequence by NCBI. }
#' \item{\code{dblink}:}{ \code{character}; Cross-references to resources that
#'      support the existence a sequence record, such as the Project Database
#'      and the NCBI Trace Assembly Archive. }
#' \item{\code{dbsource}:}{  \code{character}; GenPept files only }
#' \item{\code{keywords}:}{ code{character}; Short description of gene products
#'      and other information about an entry. }
#' \item{\code{source}:}{ \code{character}; Common name of the organism. }
#' \item{\code{organism}:}{ \code{character}; Formal scientific name of the
#'      organism. }
#' \item{\code{taxonomy}:}{ \code{character}; Taxonomic classification levels. }
#' \item{\code{references}:}{ Citations for all articles containing data
#'      reported in the entry.A \code{\linkS4class{gbReferenceList}} object. }
#' \item{\code{comment}:}{ \code{character}; Remarks. }
#' }
#' @section Extends: All reference classes extend and inherit methods from
#'    \code{"\linkS4class{envRefClass}"}.
#' @keywords classes internal
#' @examples
#' showClass("gbHeader")
NULL

#' Generator object for the \code{"seqinfo"} reference class
#'
#' @param ... List of arguments; must be named arguments
#' corresponding to the fields of a \code{\linkS4class{gbHeader}} object
#' 
#' @section Methods:
#' \describe{
#' \item{\code{#new(header = NULL, sequence = NULL)}:}{
#'    Create a new \code{\linkS4class{gbHeader}} object}
#' }
#'    
#' @keywords classes internal
seqinfo <- setRefClass(
  'seqinfo',
  fields = list(
    header = 'ANY',
    sequence = 'ANY'
  ),
  methods = list(
    initialize = function(header = NULL, sequence = NULL) {
      header <<- header
      sequence <<- sequence
    },
    header_is_empty = function() {
      is.null(header)
    },
    sequence_is_empty = function() {
      is.null(sequence)
    },
    is_empty = function() {
      header_is_empty() && sequence_is_empty()
    },
    clone = function() {
      .self$copy(shallow = TRUE)
    },
    show = function() {
      if (header_is_empty()) {
        acc <- len <- def <- ''
      } else {
        acc <- collapse(getAccession(.self), '; ')
        len <- paste0(getLength(.self), ' ', getMoltype(.self))
        def <- getDefinition(.self)
        acc <- pad(acc, nchar(acc) + 2, "right")
        len <- pad(len, nchar(len) + 2, "right")
        def <- ellipsize(def, width = getOption("width") - 
                           nchar(acc) - nchar(len) - 3)
      }
      cat(sprintf("%s\n%s%s%s", "Seqinfo:", acc, len, def))
    }
  )
)

#' Generates a container for header and sequence information.
#' @name seqinfo-class
#' @section Fields:
#' \describe{
#' \item{\code{header}:}{ A \code{\linkS4class{gbHeader}} object or \code{NULL}. }
#' \item{\code{sequence}:}{  A \code{\linkS4class{XStringSet}} object or \code{NULL}. }
#' }
#' @section Extends: All reference classes extend and inherit methods from
#'    \code{"\linkS4class{envRefClass}"}.
#' 
#' @keywords classes internal
#' @examples
#' showClass("seqinfo")
NULL

## Internal Getters

setMethod('.header', 'seqinfo', function(x) {
  if (x$header_is_empty()) {
    return(.gbHeader())
  }
  x$header
})

setMethod('.sequence', 'seqinfo', function(x) {
  if (x$sequence_is_empty()) {
    return(Biostrings::BStringSet())
  }
  x$sequence
})

setMethod('.locus', 'seqinfo', function(x) .header(x)$locus)

## Getters

#' @rdname accessors
setMethod("getLocus", "seqinfo", function(x) .locus(x)$lnm)

#' @rdname accessors
setMethod("getLength", "seqinfo", function(x) .locus(x)$len)

#' @rdname accessors
setMethod("getMoltype", "seqinfo", function(x) .locus(x)$mtp)

#' @rdname accessors
setMethod("getTopology", "seqinfo", function(x) .locus(x)$top)

#' @rdname accessors
setMethod("getDivision", "seqinfo", function(x) .locus(x)$div)

#' @rdname accessors
setMethod("getDate", "seqinfo", function(x) {
  c(create_date = .locus(x)$cdt, update_date = .locus(x)$mdt)
})

#' @rdname accessors
setMethod("getDefinition", "seqinfo", function(x) .header(x)$definition)

#' @rdname accessors
setMethod("getAccession", "seqinfo", function(x) .header(x)$accession)

#' @rdname accessors
setMethod("getVersion", "seqinfo", function(x) .header(x)$version)

#' @rdname accessors
setMethod("getGeneID", "seqinfo", function(x, db = 'gi') {
  seqid <- .header(x)$seqid
  if (is.na(seqid)) {
    seqid
  } else {
    db.idx <- which(strsplitN(seqid, "|", 1, fixed = TRUE) == db)
    strsplitN(seqid, "|", 2, fixed = TRUE)[db.idx]
  }
})

#' @rdname accessors
setMethod("getDBLink", "seqinfo", function(x) .header(x)$dblink)

#' @rdname accessors
setMethod("getDBSource", "seqinfo", function(x) .header(x)$dbsource)

#' @rdname accessors
setMethod("getSource", "seqinfo", function(x) .header(x)$source)

#' @rdname accessors
setMethod("getOrganism", "seqinfo", function(x) .header(x)$organism)

#' @rdname accessors
setMethod("getTaxonomy", "seqinfo", function(x) .header(x)$taxonomy)

#' @rdname accessors
setMethod("getReference", "seqinfo", function(x) .header(x)$references)

#' @rdname accessors
setMethod("getKeywords", "seqinfo", function(x) .header(x)$keywords)

#' @rdname accessors
setMethod("getComment", "seqinfo", function(x) .header(x)$comment)

