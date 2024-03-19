module ReVIEW
  module LATEXBuilderOverride
    # gem install unicode-display_width
    require 'unicode/display_width'
    require 'unicode/display_width/string_ext'

    CR = '→' # 送り出し文字。LaTeXコードも可
    ZWSCALE = 0.875 # 和文・欧文の比率。\setlength{\xkanjiskip}{\z@} しておいたほうがよさそう

    def split_line(s, n)
      # 文字列を幅nで分割
      a = []
      l = ''
      w = 0
      s.each_char do |c|
        cw = c.display_width(2) # Ambiguousを全角扱い
        cw *= ZWSCALE if cw == 2

        if w + cw > n
          a.push(l)
          l = c
          w = cw
        else
          l << c
          w += cw
        end
      end
      a.push(l)
      a
    end

    def code_line(type, line, idx, id, caption, lang)
      # _typeには'emlist'などが入ってくるので、環境に応じて分岐は可能
      n = 76
      n = 60 if @doc_status[:column]
      a = split_line(unescape(detab(line)), n)
      # インラインopはこの時点でもう展開されたものが入ってしまっているので、escapeでエスケープされてしまう…
      escape(a.join("\x01\n")).gsub("\x01", CR) + "\n"
    end

    def code_line_num(type, line, first_line_num, idx, id, caption, lang)
      n = 60
      n = 56 if @doc_status[:column]
      a = split_line(unescape(detab(line)), n)
      (idx + first_line_num).to_s.rjust(2) + ': ' + escape(a.join("\x01\n    ")).gsub("\x01", CR) + "\n"
    end
  end

  class LATEXBuilder
    prepend LATEXBuilderOverride
  end
end