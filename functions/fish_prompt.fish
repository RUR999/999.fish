function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end


function fish_prompt
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)  
  set -l cwd $blue(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    if test (_git_branch_name) = 'master'
      set -l git_branch (_git_branch_name)
      set git_info "$cyan ($red$git_branch$cyan)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$cyan <$blue$git_branch$cyan>"
    end
    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end
set -g last_status $status
  if test $last_status = 0
  set clr (set_color -o green)
  else
  set clr (set_color -o red)
  end
echo -n $cyan "┏━━━━━⟫"
echo -n $clr "$name"
echo $cyan "ﮩ٨ـﮩﮩ٨ـﮩ٨ـﮩﮩ٨ـ"
echo -n $cyan "┣━━━⟫"
echo -n "$cwd"
echo "$git_info"
echo -n $cyan "┗━━"
set_color 00ff00
echo -n "⟫"
set_color 5fd700
echo -n "⟫"
set_color 518700
echo -n "⟫ "
echo -n $normal
end
function fish_right_prompt
  set -g last_status $status
  if test $last_status = 0
  set_color -o green
  set status_indicator "✔︎ "
  else
  set_color -o red
  set status_indicator "✘ "
  end
  set -l duration (runtime)
  echo -n -s "$status_indicator$duration" (set_color normal)   
end

function runtime -d 'command run time'
  set -l days ''; set -l hours ''; set -l minutes ''; set -l seconds ''
  set -l duration (expr $CMD_DURATION / 1000)
  if [ $duration -gt 0 ]
    set seconds (expr $duration \% 68400 \% 3600 \% 60)'s'
    if [ $duration -ge 60 ]
      set minutes (expr $duration \% 68400 \% 3600 / 60)'m'
      if [ $duration -ge 3600 ]
        set hours (expr $duration \% 68400 / 3600)'h'
      end
    end
  end
  set_color 808080
  echo -n $hours$minutes$seconds
end
set name "999+"
