local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("php", {
  s(
    "?p",
    fmta([[<?php {data} ?>]], {
      data = i(1, ""),
    }, { delimiters = "{}" })
  ),
  s(
    "met",
    fmta(
      [[
public function <method> (<params>): <return_type>{
  <body>
}
  ]],
      {
        method = i(1),
        params = i(2, ""),
        return_type = i(3, "void"),
        body = i(4, "// body"),
      }
    )
  ),
  s(
    "pmet",
    fmta(
      [[
private function <method> (<params>): <return_type>{
  <body>
}
  ]],
      {
        method = i(1),
        params = i(2, ""),
        return_type = i(3, "void"),
        body = i(4, "// body"),
      }
    )
  ),
  s(
    "icon",
    fmta(
      [[
      <?php echo icon(name: {name}, class: {class}); ?>
      ]],
      {
        name = i(1, "''"),
        class = i(2, "'size-4'"),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "wtp",
    fmta(
      [[
      <?php echo whatsapp()->link(
        phone: {phone},
        message: {message},
        text: {text},
        class: {class}
      ); ?>
      ]],
      {
        phone = i(1, "constant('WHATSAPP_NUMBER')"),
        message = i(2, "constant('WHATSAPP_MESSAGE')"),
        text = i(3, "'Solicitar orçamento'"),
        class = i(4, "'btn-primary'"),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "picture",
    fmta(
      [[
      <?php echo image()->picture(
        name: {name},
        alt: {alt},
        class: {class},
      ); ?>
      ]],
      {
        name = i(1, "''"),
        alt = i(2, "''"),
        class = i(3, "''"),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "cc",
    fmta(
      [[
      <!-- {comment} -->
      <div class="{class}">
        {content}
      </div>
      <!-- end of {comment_repeat} -->
      ]],
      {
        comment = i(1, "container comment"),
        class = i(2, "container-class"),
        content = i(3, "// content"),
        comment_repeat = rep(1),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "acc",
    fmta(
      [[
      <!-- {comment} -->
      <article class="{class}">
        {content}
      </article>
      <!-- end of {comment_repeat} -->
      ]],
      {
        comment = i(1, "container comment"),
        class = i(2, "container-class"),
        content = i(3, "// content"),
        comment_repeat = rep(1),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "hcc",
    fmta(
      [[
      <!-- header -->
      <header class="{class}">
        {content}
      </header>
      <!-- end of header -->
      ]],
      {
        class = i(1, "container-class"),
        content = i(2, "// content"),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "loop",
    fmta(
      [[
      <?php if($query->have_posts()):
        while($query->have_posts()): $query->the_post();
          get_template_part(
            slug: 'template-parts/{path}/content',
            name:'{name}',
            args: {args}
          );
        endwhile;
        wp_reset_postdata();
      else:
        echo '<p class="text-center">{message}</p>'
      endif; ?>
      ]],
      {
        path = i(1, "default"),
        name = i(2, "default"),
        args = i(3, "[]"),
        message = i(4, "Não existem artigos publicados no momento."),
      },
      { delimiters = "{}" }
    )
  ),
  s(
    "tp",
    fmta(
      [[
        <?php get_template_part(
            slug: 'template-parts/{path}/content',
            name:'{name}',
            args: {args}
        ); ?>
      ]],
      {
        path = i(1, "default"),
        name = i(2, "default"),
        args = i(3, "[]"),
      },
      { delimiters = "{}" }
    )
  ),
})
