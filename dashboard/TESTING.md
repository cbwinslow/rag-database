# Test Suite Documentation

This document provides instructions for running and maintaining the test suite for the Database Monitoring Dashboard.

## Test Suite Structure

```
dashboard/
├── __tests__/
│   ├── api/
│   │   ├── services.test.ts
│   │   └── health.test.ts
│   ├── components/
│   │   ├── ServiceStatus.test.tsx
│   │   ├── SystemMetrics.test.tsx
│   │   └── ServiceControl.test.tsx
│   └── utils/
├── test-utils.ts
└── jest.config.js
```

## Running Tests

### Prerequisites

Make sure you have installed all dependencies:

```bash
npm install
```

### Running All Tests

```bash
npm test
```

### Running Tests in Watch Mode

```bash
npm run test:watch
```

### Running Tests with Coverage

```bash
npm run test:coverage
```

### Running Specific Test Types

```bash
# Run unit tests
npm run test:unit

# Run integration tests
npm run test:integration

# Run end-to-end tests
npm run test:e2e
```

## Test Configuration

The test suite is configured using Jest with the following settings:

- **Test Environment**: jsdom (for browser-like testing)
- **TypeScript Support**: ts-jest
- **Coverage Threshold**: 80% for branches, functions, lines, and statements
- **Module Name Mapping**: Supports absolute imports with `@/` prefix

## Writing Tests

### Component Tests

When writing tests for React components:

1. Use `@testing-library/react` for rendering components
2. Use `@testing-library/user-event` for simulating user interactions
3. Test both happy paths and error conditions
4. Use descriptive test names

Example:
```typescript
import { render, screen } from '@testing-library/react'
import MyComponent from '../components/MyComponent'

describe('MyComponent', () => {
  it('renders correctly', () => {
    render(<MyComponent />)
    expect(screen.getByText('Expected Text')).toBeInTheDocument()
  })
})
```

### API Route Tests

When testing API routes:

1. Import the route handler directly
2. Call the handler function with mock request objects
3. Assert on the response status and data

Example:
```typescript
import { GET } from '../app/api/my-route/route'

describe('My API Route', () => {
  it('returns correct data', async () => {
    const response = await GET()
    const data = await response.json()
    
    expect(response.status).toBe(200)
    expect(data).toHaveProperty('expectedProperty')
  })
})
```

## Test Utilities

### Test Data

The test suite includes mock data for testing components and API routes. This data is defined in the test files themselves to keep tests self-contained.

### Custom Matchers

The test suite extends Jest with custom matchers from `@testing-library/jest-dom`:

- `toBeInTheDocument()`
- `toBeChecked()`
- `toHaveClass()`
- And many more

## Coverage Reporting

Running tests with coverage generates a detailed report in the `coverage/` directory:

- **HTML Report**: `coverage/lcov-report/index.html`
- **JSON Report**: `coverage/coverage-summary.json`
- **Text Summary**: Printed to the console

## Continuous Integration

The test suite is designed to run in CI environments. Make sure your CI configuration:

1. Installs dependencies: `npm ci`
2. Runs tests: `npm test`
3. Collects coverage reports
4. Fails builds on test failures or low coverage

## Troubleshooting

### Common Issues

1. **Tests failing due to missing dependencies**
   - Run `npm install` to ensure all dependencies are installed

2. **TypeScript errors in tests**
   - Check that types are correctly defined
   - Ensure ts-jest is properly configured

3. **Async test timeouts**
   - Increase Jest timeout if needed: `jest.setTimeout(30000)`

### Debugging Tests

1. Use `console.log` statements in tests (they will be shown when running with `--verbose`)
2. Use the `debug()` function from `@testing-library/react` to print the DOM
3. Run specific tests with `.only` or skip tests with `.skip`

## Maintaining Tests

### Updating Tests

When updating components or API routes:

1. Update the corresponding tests
2. Ensure all tests pass
3. Maintain or improve coverage

### Refactoring Tests

When refactoring test code:

1. Keep tests focused and isolated
2. Remove duplication
3. Improve readability
4. Maintain consistent naming conventions

## Best Practices

1. **Write tests first** when possible (TDD)
2. **Keep tests independent** - each test should be able to run alone
3. **Use descriptive test names** - clearly state what is being tested
4. **Test behavior, not implementation** - focus on what the code does, not how it does it
5. **Mock external dependencies** - keep tests fast and reliable
6. **Maintain good coverage** - aim for 80%+ coverage on new features