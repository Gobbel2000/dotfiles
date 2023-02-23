#!/usr/bin/env bash

bar=${1:-all}

case $bar in
	all)
		# Terminate already running bar instances
		killall -q polybar

		# Wait until the processes have been shut down
		while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

		# Launch primary and secondary bar
		polybar primary &
		polybar secondary &
        polybar tertiary &

		echo "Bars launched..."
		;;
    
    single)
        killall -q polybar

        while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

        polybar single
        echo "One Bar launched..."
        ;;

	secondary)
		pkill -f "polybar secondary"
		while pgrep -f "polybar secondary" >/dev/null; do sleep 1; done
		polybar secondary &
		echo "Secondary bar launched..."
		;;

	primary)
		pkill -f "polybar primary"
		while pgrep -f "polybar primary" >/dev/null; do sleep 1; done
		polybar primary &
		echo "Primary bar launched..."
		;;

    tertiary)
        pkill -f "polybar tertiary"
        while pgrep -f "polybar tertiary" >/dev/null; do sleep 1; done
        polybar tertiary &
        echo "Tertiary bar launched..."
        ;;
esac
