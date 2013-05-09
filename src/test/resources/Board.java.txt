package webboards.client.data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import webboards.client.data.ref.CounterId;
import webboards.client.ex.WebBoardsException;
import webboards.client.games.Hex;
import webboards.client.games.Position;
import webboards.client.overlay.Overlay;

public abstract class Board implements Serializable {
	private static final long serialVersionUID = 1L;
	/** counters created during scenation setup*/
	private Map<CounterId, CounterInfo> counters = null;
	/** counters placed during play */
	private Map<CounterId, CounterInfo> placed = null;
	private List<Overlay> overlayes = new ArrayList<Overlay>();
	
	public Board() {
		counters = new HashMap<CounterId, CounterInfo>();
		placed = new HashMap<CounterId, CounterInfo>();
	}

	public Set<Position> getStacks() {
		Set<Position> stacks = new HashSet<Position>();
		Set<Entry<CounterId, CounterInfo>> entrySet = counters.entrySet();		
		for (Entry<CounterId, CounterInfo> entry : entrySet) {
			stacks.add(entry.getValue().getPosition());
		}
		return stacks;
	}

	public Collection<CounterInfo> getCounters() {
		return Collections.unmodifiableCollection(counters.values());
	}

	public CounterInfo getCounter(CounterId id) {
		CounterInfo c;
		c = counters.get(id);
		if(c != null) {
			return c;			
		}
		c = placed.get(id);
		if(c != null) {
			return c;			
		}
		throw new WebBoardsException("Counter "+id+" not found.");
	}
	
	public void place(Position to, CounterInfo counter) {
		placed.put(counter.ref(), counter);
        move(to, counter);
	}

	public void setup(Position to, CounterInfo counter) {
		CounterId id = counter.ref();
		CounterInfo prev = counters.put(id, counter);
		if (prev != null) {
			throw new WebBoardsException(id + " aleader placed");
		}
		move(to, counter);
	}

	public void move(Position to, CounterInfo counter) {
		Position from = counter.getPosition();
		if(from != null) {
			getInfo(from).pieces.remove(counter);
		}
		counter.setPosition(to);
		getInfo(to).pieces.add(counter);
	}

	public List<HexInfo> getAdjacent(Hex p) {
		List<HexInfo> adj = new ArrayList<HexInfo>(6);
		int o = (p.x % 2 == 0) ? 0 : -1;
		//@formatter:off
								adj.add(toId(p.x,p.y+1));
		adj.add(toId(p.x-1,p.y+1+o));					adj.add(toId(p.x+1,p.y+1+o));	
		adj.add(toId(p.x-1,p.y+o));						adj.add(toId(p.x+1,p.y+o));
								adj.add(toId(p.x,p.y-1));
		//@formatter:on
		return adj;
	}
	
	private HexInfo toId(int x, int y) {
		return getInfo(new Hex(x, y));
	}

	public abstract HexInfo getInfo(Position area);

	public CounterInfo getInfo(CounterId ref) {
		return getCounter(ref);
	}
	
	public Collection<CounterInfo> getPlaced() {
		return Collections.unmodifiableCollection(placed.values());
	}
}
