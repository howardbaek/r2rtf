#    Copyright (c) 2022 Merck & Co., Inc., Rahway, NJ, USA and its affiliates. All rights reserved.
#
#    This file is part of the r2rtf program.
#
#    r2rtf is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

#' Derive Space Adjustment
#'
#' @param tbl A data frame.
#' @param text_indent_reference The reference start point of text indent. Accept `table` or `page_margin`
#'
#' @return a value indicating the amount of space adjustment
#'
#' @section Specification:
#' \if{latex}{
#'  \itemize{
#'    \item Collect page width, page margins and table width attributes from `tbl` object.
#'    \item Convert the attributes from inch to twip using 'inch_to_twip()'.
#'    \item Derive the adjusted space by discounting page margins and table width from page width, then divided by 2.
#'    \item Set the adjusted space to 0 if previous derivation returns to negative value.
#'  }
#'  }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
footnote_source_space <- function(tbl,
                                  text_indent_reference = "table") {
  # Input checking
  match_arg(text_indent_reference, c("table", "page_margin"))
  check_args(text_indent_reference, "character", length = 1)

  if (text_indent_reference == "page_margin") {
    return(0)
  }

  page <- attr(tbl, "page")
  page_width <- inch_to_twip(page$width)
  page_margin <- inch_to_twip(page$margin)

  table_width <- inch_to_twip(page$col_width)

  left_margin <- page_margin[1]
  right_margin <- page_margin[2]

  space_adjust <- round((page_width - left_margin - right_margin - table_width) / 2)

  space_adjust
}
