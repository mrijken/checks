return {
  {
    "jeangiraldoo/codedocs.nvim",
    opts = {
      default_styles = { python = "Google" },
    },
    keys = {
      {
        "<leader>k",
        require("codedocs").insert_docs,
        desc = "Insert docstring",
      },
    },
  },
}
