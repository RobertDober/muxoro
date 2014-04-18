Feature: Basic Use Case

  As a user of the muxoro gem
  When I run muxoro without any arguments
  I want to have a pomodoro timer in all my tmux sessions
  and I want to the timer to count down from 25 to 0.

  Scenario: No Tmux sessions
    Given no tmux sessions
    When I run `muxoro`
    Then the stderr should contain "No sessions"
    And the exit status should be 255

