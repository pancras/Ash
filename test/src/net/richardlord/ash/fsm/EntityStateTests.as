package net.richardlord.ash.fsm
{

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	public class EntityStateTests
	{
		private var state : EntityState;

		[Before]
		public function createState() : void
		{
			state = new EntityState();
		}

		[After]
		public function clearState() : void
		{
			state = null;
		}
		
		[Test]
		public function addWithNoQualifierCreatesTypeProvider() : void
		{
			state.add( MockComponent );
			var provider : ComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentTypeProvider ) );
			assertThat( provider.component, instanceOf( MockComponent ) );
		}
		
		[Test]
		public function addWithTypeQualifierCreatesTypeProvider() : void
		{
			state.add( MockComponent ).withType( MockComponent2 );
			var provider : ComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentTypeProvider ) );
			assertThat( provider.component, instanceOf( MockComponent2 ) );
		}
		
		[Test]
		public function addWithInstanceQualifierCreatesInstanceProvider() : void
		{
			var component : MockComponent = new MockComponent();
			state.add( MockComponent ).withInstance( component );
			var provider : ComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentInstanceProvider ) );
			assertThat( provider.component, equalTo( component ) );
		}
		
		[Test]
		public function addWithSingletonQualifierCreatesSingletonProvider() : void
		{
			state.add( MockComponent ).withSingleton( MockComponent );
			var provider : ComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentSingletonProvider ) );
			assertThat( provider.component, instanceOf( MockComponent ) );
		}
	}
}

class MockComponent
{
	public var value : int;
}

class MockComponent2 extends MockComponent
{
	
}