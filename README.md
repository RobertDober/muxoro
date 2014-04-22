# muxoro


Pomodoro Timer for Tmux Sessions

## Ridiculously Fast Starting Guide

```
      gem install muxoro
      muxoro
```

If in a tmux session update the current session only. Otherwise updates all tmux sessions' 
left status with a Pomodoro timer of 25' counting down to 0.
This updates the status every minute.

## Improbably Fast Starting Guide


```
      muxoro sessions: 0,Mine time:20
```

Updates sessions 0's and Mine's left status with a Pomodoro timer of 20' counting down to 0.
This still updates the status every minute.


## Fantastically Fast Starting Guide


```
    muxoro :help
```

Which gives the following (unless I forgot to copy the latest version's output into the README of course)

```
    Coming reallly really soon (before the gem's release in any case)
```

## Boringly Slow Examples

### Time Span Semantics

Indicate time spans in minutes (default) or seconds, this concerns the parameters `time`, `interval` and
`clearance`

```
    muxoro time: 25, intervals: 20, clearance: 100s
```

A pomodoro timer for 25 minutes and 25 intervals (interval times computed to a value greater than one minute
are rounded). The interval between expiry and clearance of the status line is 1'40".

```
    muxoro time: 20, interval: 3
```

This is ambigous, the implementation can do one of two things here, either (i) have a timer of a duration of
21' composed of 7 intervals, or (ii) a timer of 20' composed of 6 intervals of 3' and one last of 2'.
In order to avoid this potential ambiguity the following syntax is preferable:

```
    muxoro interval: 3, intervals: 8
```

#### Clearance

By default muxoro will clear the status bar after an additional interval, but the duration of this
additional interval can be overridden by the `clearance` parameter.

The following will create a deafult timer of a duration of 25' and an interval of 1', but with
a clearance of 2'.
 
```
    muxoro clearance: 2
```

### Format Semantics

For now only colors for the final status update (the one counting down to 0) can be given. They default to
`bg: red fg: black`.

```
    muxoro fg: '#ff00dd', bg: '#ddaacc'
```

### Reading Parameters from a Configuration File


Coming Soon
