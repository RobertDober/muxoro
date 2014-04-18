Feature: Help page

  In order to see all command line options of the muxoro executable
  So that I can call the executable with the correct options
  I want to see the correct text

  Scenario: Help text
    When I run `muxoro :help`
    Then the output should contain:
    """
    muxoro [options]
    """


